import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/features/dashboard/presentation/data/models/activity_repository.dart';
import 'package:osm/features/dashboard/presentation/data/models/recent_activities.dart';
import 'package:osm/features/orders/data/models/order_model.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/prescription/data/models/prescription_model.dart';
import 'package:osm/features/inventory/data/models/store_location_model.dart';
import 'package:osm/features/orders/data/models/order_model_enums.dart';
import 'package:osm/core/services/isar_service.dart';

class OrderRepository extends ChangeNotifier {
  final IsarService _isarService;
  final ActivityRepository _activityRepository;

  int _totalOrders = 0;
  double _todaysSale = 0.0;
  double _pendingPayments = 0.0;
  List<double> _weeklySummary = [];

  List<double> get weeklySummary => _weeklySummary;
  double get todaysSale => _todaysSale;
  double get pendingPayments => _pendingPayments;
  int get totalOrders => _totalOrders;

  OrderRepository(this._isarService, this._activityRepository) {
    _isarService.db.then((isar) {
      // Whenever orders change, recalc all metrics
      isar.orderModels.watchLazy().listen((_) async {
        await refreshAllMetrics();
      });
    });
  }

  Future<void> init() async {
    await refreshTotalOrdersCount();
    await refreshAllMetrics();
  }

  Future<Id> add(
    OrderModel order, {
    required CustomerModel customer,
    required PrescriptionModel prescription,
    StoreLocationModel? storeLocation,
  }) async {
    try {
      final isar = await _isarService.db;
      late Id newOrderId;

      await isar.writeTxn(() async {
        // 1. Save customer and prescription if they don't have IDs
        if (customer.id == Isar.autoIncrement) {
          customer.id = await isar.customerModels.put(customer);
        }
        if (prescription.id == Isar.autoIncrement) {
          prescription.id = await isar.prescriptionModels.put(prescription);
        }

        // 2. Set relationships on the order
        order.customer.value = customer;
        order.prescription.value = prescription;
        if (storeLocation != null) {
          if (storeLocation.id == Isar.autoIncrement) {
            storeLocation.id = await isar.storeLocationModels.put(
              storeLocation,
            );
          }
          order.storeLocation.value = storeLocation;
        }

        newOrderId = await isar.orderModels.put(order);

        // Update backlinks for Customer & prescriptions
        customer.orders.add(order);
        await customer.orders.save();

        prescription.orders.add(order);
        await prescription.orders.save();

        if (storeLocation != null) {
          storeLocation.orders.add(order);
          await storeLocation.orders.save();
        }
        await _activityRepository.log(
          ActivityModel(
            type: ActivityType.newOrder,
            title: "New Order #$newOrderId",
            subtitle:
                "${customer.firstName} ${customer.lastName} • ${order.totalAmount}",
            time: DateTime.now(),
          ),
          isar: isar,
        );
      });
      refreshAllMetrics();
      return newOrderId;
    } catch (e) {
      debugPrint('Error adding order: $e');
      rethrow;
    }
  }

  // Updates an existing order.
  Future<void> update(OrderModel order) async {
    try {
      final isar = await _isarService.db;
      await isar.writeTxn(() async {
        await isar.orderModels.put(order);
      });
    } catch (e) {
      debugPrint('Error updating order: $e');
      rethrow;
    }
  }

  // Deletes an order by its ID.
  Future<bool> delete(Id id) async {
    try {
      final isar = await _isarService.db;
      late bool deleted;
      await isar.writeTxn(() async {
        deleted = await isar.orderModels.delete(id);
      });
      _totalOrders--;
      notifyListeners();
      return deleted;
    } catch (e) {
      debugPrint('Error deleting order: $e');
      rethrow;
    }
  }

  Future<void> calculateTodaysSale() async {
    final isar = await _isarService.db;
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    final result = await isar.orderModels
        .filter()
        .orderDateGreaterThan(startOfDay)
        .findAll();

    _todaysSale = result.fold(0.0, (sum, order) => sum + order.totalAmount);
  }

  Future<void> calculatePendingPayments() async {
    final isar = await _isarService.db;

    final orders = await isar.orderModels.where().findAll();

    double pending = 0.0;

    for (final order in orders) {
      await order.payments.load(); // load linked payments

      double paidAmount = 0.0;
      for (final payment in order.payments) {
        paidAmount += payment.amountPaid;
      }

      final due = order.totalAmount - paidAmount;
      if (due > 0) {
        pending += due;
      }
    }

    _pendingPayments = pending;
  }

  // Retrieves all orders.
  Future<List<OrderModel>> getAll() async {
    try {
      final isar = await _isarService.db;
      final orders = await isar.orderModels.where().findAll();
      for (final order in orders) {
        await order.loadAllRelations();
      }
      return orders;
    } catch (e) {
      debugPrint('Error getting all orders: $e');
      rethrow;
    }
  }

  // Retrieves an order by its ID and loads its customer, prescription, items, payments, and store location.
  Future<OrderModel?> getOrderWithDetails(Id id) async {
    try {
      final isar = await _isarService.db;
      final order = await isar.orderModels.get(id);
      await order?.loadAllRelations();
      return order;
    } catch (e) {
      debugPrint('Error getting order with details by ID $id: $e');
      rethrow;
    }
  }

  // Retrieves orders for a specific customer.
  Future<List<OrderModel>> getOrdersForCustomer(Id customerId) async {
    try {
      final isar = await _isarService.db;
      final orders = await isar.orderModels
          .filter()
          .customer((q) => q.idEqualTo(customerId))
          .findAll();

      await Future.wait(orders.map((o) => o.loadAllRelations()));

      return orders;
    } catch (e) {
      debugPrint('Error getting orders for customer $customerId: $e');
      rethrow;
    }
  }

  Future<double> getTotalSpentByCustomer(Id customerId) async {
    try {
      final orders = await getOrdersForCustomer(customerId);
      double total = 0.0;

      for (final order in orders) {
        total += order.totalAmount;
      }

      return total;
    } catch (e) {
      debugPrint('Error calculating total spent for $customerId: $e');
      rethrow;
    }
  }

  Future<DateTime?> getLastVisitDate(Id customerId) async {
    try {
      final isar = await _isarService.db;
      final latestOrder = await isar.orderModels
          .filter()
          .customer((q) => q.idEqualTo(customerId))
          .sortByOrderDateDesc()
          .findFirst();
      return latestOrder?.orderDate;
    } catch (e) {
      debugPrint('Error getting last visit for $customerId: $e');
      rethrow;
    }
  }

  Future<List<OrderModel>> getOrderByDate(DateTime date) async {
    try {
      final isar = await _isarService.db;
      final start = DateTime(date.year, date.month, date.day);
      final end = start.add(const Duration(days: 1));

      final orders = await isar.orderModels
          .filter()
          .orderDateBetween(start, end, includeLower: true, includeUpper: false)
          .findAll();
      await Future.wait(orders.map((o) => o.loadAllRelations()));
      return orders;
    } catch (e) {
      debugPrint("Error getting order for date $date: $e");
      rethrow;
    }
  }

  Future<void> getWeeklySummary() async {
    DateTime today = DateTime.now();

    int weekday = today.weekday;
    DateTime startOfWeek = today.subtract(Duration(days: weekday - 1));

    for (int i = 0; i < 7; i++) {
      DateTime targetDay = DateTime(
        startOfWeek.year,
        startOfWeek.month,
        startOfWeek.day + i,
      );

      List<OrderModel> orders = await getOrderByDate(targetDay);

      double total = orders.fold(
        0.0,
        (sum, order) => sum + (order.totalAmount),
      );

      _weeklySummary.add(total);
    }
  }

  Future<List<OrderModel>> getUnpaidOrders() async {
    final isar = await _isarService.db;
    return await isar.orderModels.filter().paymentsLengthEqualTo(0).findAll();
  }

  Future<void> refreshTotalOrdersCount() async {
    final isar = await _isarService.db;
    final count = await isar.orderModels.count();
    _totalOrders = count;
  }

  Future<void> refreshAllMetrics() async {
    await getWeeklySummary();
    await refreshTotalOrdersCount();
    await calculateTodaysSale();
    await calculatePendingPayments();
    notifyListeners();
  }
}

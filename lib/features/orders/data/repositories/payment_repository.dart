import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/features/dashboard/presentation/data/models/recent_activities.dart';
import 'package:osm/features/orders/data/models/payment_model.dart';
import 'package:osm/features/orders/data/models/order_model.dart';
import 'package:osm/core/services/isar_service.dart';

class PaymentRepository {
  final IsarService _isarService;

  PaymentRepository(this._isarService);

  // Retrieves all payments from the database.
  Future<List<PaymentModel>> getAll() async {
    try {
      final isar = await _isarService.db;
      return await isar.paymentModels.where().findAll();
    } catch (e) {
      debugPrint('Error getting all payments: $e');
      rethrow;
    }
  }

  // Retrieves a single payment by its ID.
  Future<PaymentModel?> getById(Id id) async {
    try {
      final isar = await _isarService.db;
      return await isar.paymentModels.get(id);
    } catch (e) {
      debugPrint('Error getting payment by ID $id: $e');
      rethrow;
    }
  }

  // Retrieves a payment and eagerly loads its associated order.
  Future<PaymentModel?> getPaymentWithOrder(Id id) async {
    try {
      final isar = await _isarService.db;
      final payment = await isar.paymentModels.get(id);
      if (payment != null) {
        await payment.order.load();
      }
      return payment;
    } catch (e) {
      debugPrint('Error getting payment with order by ID $id: $e');
      rethrow;
    }
  }

  // Adds a new payment to the database and links it to an existing order.
  Future<Id> add(PaymentModel payment, {required OrderModel order}) async {
    try {
      final isar = await _isarService.db;
      late Id newId;
      await isar.writeTxn(() async {
        // Ensure order has an ID
        if (order.id == Isar.autoIncrement) {
          await isar.orderModels.put(order);
        }

        payment.order.value = order;
        newId = await isar.paymentModels.put(payment);

        // Save the forward link
        order.payments.add(payment);
        await isar.orderModels.put(order);

        await isar.activityModels.put(
          ActivityModel(
            type: ActivityType.paymentReceived,
            title: "Payment received ₹${payment.amountPaid} from ${order.customer.value?.firstName} ${order.customer.value?.lastName}",
            subtitle: "Remaining payment: ₹${order.totalAmount - payment.amountPaid}",
            time: DateTime.now()
          )
        );
      });
      return newId;
    } catch (e) {
      debugPrint('Error adding payment: $e');
      rethrow;
    }
  }

  // Updates an existing payment in the database.
  Future<void> update(PaymentModel payment) async {
    try {
      final isar = await _isarService.db;
      await isar.writeTxn(() async {
        await isar.paymentModels.put(payment);
      });
    } catch (e) {
      debugPrint('Error updating payment: $e');
      rethrow;
    }
  }

  // Deletes a payment by its ID.
  Future<bool> delete(Id id) async {
    try {
      final isar = await _isarService.db;
      late bool deleted;
      await isar.writeTxn(() async {
        deleted = await isar.paymentModels.delete(id);
      });
      return deleted;
    } catch (e) {
      debugPrint('Error deleting payment: $e');
      rethrow;
    }
  }

  // Retrieves payments for a specific order.
  Future<List<PaymentModel>> getPaymentsForOrder(OrderModel order) async {
    try {
      await order.payments.load(); // load backlink
      return order.payments.toList();
    } catch (e) {
      debugPrint('Error getting payments for order $order: $e');
      rethrow;
    }
  }

  // Calculates outstanding balance of an order
  Future<double> getOutstandingBalance(OrderModel order) async {
    await order.items.load();
    await order.payments.load();

    final total = order.totalAmount;
    final paid = order.payments.fold(0.0, (sum, p) => sum + p.amountPaid);

    return total - paid;
  }
}

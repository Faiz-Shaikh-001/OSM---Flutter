import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/features/orders/data/models/order_model.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/prescription/data/models/prescription_model.dart';
import 'package:osm/features/inventory/data/models/store_location_model.dart';
import 'package:osm/core/services/isar_service.dart';

class OrderRepository {
  final IsarService _isarService;

  OrderRepository(this._isarService);

  // Retrieves all orders.
  Future<List<OrderModel>> getAll() async {
    try {
      final isar = await _isarService.db;
      return await isar.orderModels.where().findAll();
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
      if (order != null) {
        await order.customer.load();
        await order.prescription.load();
        await order.items.load();
        await order.payments.load();
        await order.storeLocation.load();
      }
      return order;
    } catch (e) {
      debugPrint('Error getting order with details by ID $id: $e');
      rethrow;
    }
  }

  // Adds a new order and links it to existing customer and prescription.
  // Ensure customer and prescription models are already persisted in Isar
  // before calling this method.
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
        // Link the order to the customer and prescription
        order.customer.value = customer;
        order.prescription.value = prescription;
        if (storeLocation != null) {
          order.storeLocation.value = storeLocation;
        }

        newOrderId = await isar.orderModels.put(order);

        // Save the links on the "many" side (backlinks)
        // These are typically handled by Isar when the 'one' side is put,
        // but explicitly calling save() on the IsarLinks is good practice
        // if you want to ensure immediate consistency or when dealing with complex scenarios.
        await customer.orders.save();
        await prescription.orders.save();
        if (storeLocation != null) {
          await storeLocation.orders.save();
        }
      });
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
      return deleted;
    } catch (e) {
      debugPrint('Error deleting order: $e');
      rethrow;
    }
  }

  // Retrieves orders for a specific customer.
  Future<List<OrderModel>> getOrdersForCustomer(Id customerId) async {
    try {
      final isar = await _isarService.db;
      return await isar.orderModels
          .filter()
          .customer((q) => q.idEqualTo(customerId))
          .findAll();
    } catch (e) {
      debugPrint('Error getting orders for customer $customerId: $e');
      rethrow;
    }
  }
}

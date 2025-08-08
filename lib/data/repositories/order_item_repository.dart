import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/data/models/order_item_model.dart';
import 'package:osm/data/models/order_model.dart';
import 'package:osm/data/models/frame_model.dart';
import 'package:osm/data/models/lens_model.dart';
import 'package:osm/services/isar_service.dart';

class OrderItemRepository {
  final IsarService _isarService;

  OrderItemRepository(this._isarService);

  // Retrieves all order items from the database.
  Future<List<OrderItemModel>> getAll() async {
    try {
      final isar = await _isarService.db;
      return await isar.orderItemModels.where().findAll();
    } catch (e) {
      debugPrint('Error getting all order items: $e');
      rethrow;
    }
  }

  // Retrieves a single order item by its ID.
  Future<OrderItemModel?> getById(Id id) async {
    try {
      final isar = await _isarService.db;
      return await isar.orderItemModels.get(id);
    } catch (e) {
      debugPrint('Error getting order item by ID $id: $e');
      rethrow;
    }
  }

  // Retrieves an order item and eagerly loads its associated order, frame, or lens.
  Future<OrderItemModel?> getOrderItemWithDetails(Id id) async {
    try {
      final isar = await _isarService.db;
      final orderItem = await isar.orderItemModels.get(id);
      if (orderItem != null) {
        await orderItem.order.load();
        await orderItem.frame.load();
        await orderItem.lens.load();
      }
      return orderItem;
    } catch (e) {
      debugPrint('Error getting order item with details by ID $id: $e');
      rethrow;
    }
  }

  // Adds a new order item to the database and links it to an existing order,
  // and optionally to a frame or lens.
  Future<Id> add(
    OrderItemModel orderItem, {
    required OrderModel order,
    FrameModel? frame,
    LensModel? lens,
  }) async {
    try {
      final isar = await _isarService.db;
      late Id newId;
      await isar.writeTxn(() async {
        orderItem.order.value = order;
        if (frame != null) {
          orderItem.frame.value = frame;
        }
        if (lens != null) {
          orderItem.lens.value = lens;
        }
        newId = await isar.orderItemModels.put(orderItem);
      });
      return newId;
    } catch (e) {
      debugPrint('Error adding order item: $e');
      rethrow;
    }
  }

  // Updates an existing order item in the database.
  Future<void> update(OrderItemModel orderItem) async {
    try {
      final isar = await _isarService.db;
      await isar.writeTxn(() async {
        await isar.orderItemModels.put(orderItem);
      });
    } catch (e) {
      debugPrint('Error updating order item: $e');
      rethrow;
    }
  }

  // Deletes an order item by its ID.
  Future<bool> delete(Id id) async {
    try {
      final isar = await _isarService.db;
      late bool deleted;
      await isar.writeTxn(() async {
        deleted = await isar.orderItemModels.delete(id);
      });
      return deleted;
    } catch (e) {
      debugPrint('Error deleting order item: $e');
      rethrow;
    }
  }

  // Retrieves all order items for a specific order.
  Future<List<OrderItemModel>> getItemsForOrder(Id orderId) async {
    try {
      final isar = await _isarService.db;
      return await isar.orderItemModels
          .filter()
          .order((q) => q.idEqualTo(orderId))
          .findAll();
    } catch (e) {
      debugPrint('Error getting items for order $orderId: $e');
      rethrow;
    }
  }
}

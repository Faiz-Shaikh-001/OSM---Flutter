import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/data/models/inventory_model.dart';
import 'package:osm/services/isar_service.dart';
import '../models/frame_model.dart';
import '../models/lens_model.dart';

class InventoryRepository {
  final IsarService _isarService;

  InventoryRepository(this._isarService);

  // Retrieves all inventory entries from the database.
  Future<List<InventoryModel>> getAll() async {
    try {
      final isar = await _isarService.db;
      return await isar.inventoryModels.where().findAll();
    } catch (e) {
      debugPrint('Error getting all inventory entries: $e');
      rethrow;
    }
  }

  // Retrieves a single inventory entry by its ID.
  Future<InventoryModel?> getById(Id id) async {
    try {
      final isar = await _isarService.db;
      return await isar.inventoryModels.get(id);
    } catch (e) {
      debugPrint('Error getting inventory entry by ID $id: $e');
      rethrow;
    }
  }

  // Retrieves an inventory entry and eagerly loads its associated frame or lens.
  Future<InventoryModel?> getInventoryWithProduct(Id id) async {
    try {
      final isar = await _isarService.db;
      final inventory = await isar.inventoryModels.get(id);
      if (inventory != null) {
        await inventory.frame.load();
        await inventory.lens.load();
      }
      return inventory;
    } catch (e) {
      debugPrint('Error getting inventory with product by ID $id: $e');
      rethrow;
    }
  }

  // Adds a new inventory entry to the database.
  // Ensure either a frame or a lens is linked, but not both.
  Future<Id> add(
    InventoryModel inventory, {
    FrameModel? frame,
    LensModel? lens,
  }) async {
    try {
      if (frame != null && lens != null) {
        throw ArgumentError(
          'An inventory entry cannot be linked to both a Frame and a Lens.',
        );
      }
      final isar = await _isarService.db;
      late Id newId;
      await isar.writeTxn(() async {
        if (frame != null) {
          inventory.frame.value = frame;
        } else if (lens != null) {
          inventory.lens.value = lens;
        }
        newId = await isar.inventoryModels.put(inventory);
      });
      return newId;
    } catch (e) {
      debugPrint('Error adding inventory entry: $e');
      rethrow;
    }
  }

  // Updates an existing inventory entry in the database.
  Future<void> update(InventoryModel inventory) async {
    try {
      final isar = await _isarService.db;
      await isar.writeTxn(() async {
        await isar.inventoryModels.put(inventory);
      });
    } catch (e) {
      debugPrint('Error updating inventory entry: $e');
      rethrow;
    }
  }

  // Deletes an inventory entry by its ID.
  Future<bool> delete(Id id) async {
    try {
      final isar = await _isarService.db;
      late bool deleted;
      await isar.writeTxn(() async {
        deleted = await isar.inventoryModels.delete(id);
      });
      return deleted;
    } catch (e) {
      debugPrint('Error deleting inventory entry: $e');
      rethrow;
    }
  }

  // Retrieves inventory entries below their minimum stock level.
  Future<List<InventoryModel>> getLowStockItems() async {
    try {
      final isar = await _isarService.db;
      final allInventory = await isar.inventoryModels.where().findAll();
      return allInventory
          .where((item) => item.quantityOnHand < item.minStockLevel)
          .toList();
    } catch (e) {
      debugPrint('Error getting low stock items: $e');
      rethrow;
    }
  }
}

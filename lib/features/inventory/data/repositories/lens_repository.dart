// imports
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/features/inventory/data/models/inventory_model.dart';
import '../models/lens_model.dart';
import '../../../../core/services/isar_service.dart';

class LensRepository {
  final IsarService _isarService;

  LensRepository(this._isarService);

  /// Retrieves all lenses from the database.
  Future<List<LensModel>> getAll() async {
    try {
      final isar = await _isarService.db;
      final lenses = await isar.lensModels.where().findAll();

      // Debug: Check if variants exist
      for (final l in lenses) {
        debugPrint("Lens: ${l.productName}, Variants: ${l.variants.length}");
      }

      return lenses;
    } catch (e) {
      debugPrint('Error getting all lenses: $e');
      rethrow;
    }
  }

  /// Retrieves a single lens by its ID.
  Future<LensModel?> getById(Id id) async {
    try {
      final isar = await _isarService.db;
      final lens = await isar.lensModels.get(id);

      if (lens != null) {
        debugPrint(
          "Fetched Lens ${lens.productName}, Variants: ${lens.variants.length}",
        );
      }

      return lens;
    } catch (e) {
      debugPrint("Error getting lens by Id $id: $e");
      rethrow;
    }
  }

  /// Retrieves a lens and eagerly loads its associated inventory entry.
  Future<LensModel?> getLensWithInventory(Id id) async {
    try {
      final isar = await _isarService.db;
      final lens = await isar.lensModels.get(id);

      if (lens != null) {
        await lens.inventoryEntry.load();
        debugPrint(
          "Lens ${lens.productName} with inventory loaded. Variants: ${lens.variants.length}",
        );
      }
      return lens;
    } catch (e) {
      debugPrint("Error getting lens with inventory by Id $id: $e");
      rethrow;
    }
  }

  /// Add a new lens to the db (with variants if provided)
  Future<Id> add(LensModel lens) async {
    try {
      final isar = await _isarService.db;
      late Id newId;

      await isar.writeTxn(() async {
        newId = await isar.lensModels.put(lens);

        final inventory = InventoryModel(
          quantityOnHand: 0,
          minStockLevel: 1,
          lastRestockDate: DateTime.now(),
        );

        await isar.inventoryModels.put(inventory);

        lens.inventoryEntry.value = inventory;
        inventory.lens.value = lens;

        await lens.inventoryEntry.save();
        await inventory.lens.save();
      });

      debugPrint(
        "Added Lens ${lens.productName}, Variants: ${lens.variants.length}",
      );
      return newId;
    } catch (e) {
      debugPrint("Error adding lens to database: $e");
      rethrow;
    }
  }

  /// Update an existing lens model
  Future<void> update(LensModel lens) async {
    try {
      final isar = await _isarService.db;

      await isar.writeTxn(() async {
        await isar.lensModels.put(lens);
      });

      debugPrint(
        "Updated Lens ${lens.productName}, Variants: ${lens.variants.length}",
      );
    } catch (e) {
      debugPrint("Error updating lens: $e");
      rethrow;
    }
  }

  /// Adds or replaces variants for a specific lens
  Future<void> updateVariants(Id lensId, List<LensVariant> newVariants) async {
    try {
      final isar = await _isarService.db;
      final lens = await isar.lensModels.get(lensId);

      if (lens == null) {
        throw Exception("Lens not found for Id $lensId");
      }

      lens.variants
        ..clear()
        ..addAll(newVariants);

      await isar.writeTxn(() async {
        await isar.lensModels.put(lens);
      });

      debugPrint(
        "Updated Variants for Lens ${lens.productName}. Now has ${lens.variants.length} variants",
      );
    } catch (e) {
      debugPrint("Error updating variants for Lens $lensId: $e");
      rethrow;
    }
  }

  /// Delete a lens by its Id
  Future<bool> delete(Id id) async {
    try {
      final isar = await _isarService.db;
      late bool deleted;

      await isar.writeTxn(() async {
        final lens = await isar.lensModels.get(id);

        if (lens != null) {
          await lens.inventoryEntry.load();
          final inv = lens.inventoryEntry.value;
          if (inv != null) {
            await isar.inventoryModels.delete(inv.id);
          }
        }
        deleted = await isar.lensModels.delete(id);
      });

      debugPrint("Deleted Lens with Id $id → $deleted");
      return deleted;
    } catch (e) {
      debugPrint("Error deleting lens: $e");
      rethrow;
    }
  }
}

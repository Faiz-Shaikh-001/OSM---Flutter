// imports
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/features/dashboard/presentation/data/models/recent_activities.dart';
import 'package:osm/features/inventory/data/models/inventory_model.dart';
import '../models/frame_model.dart';
import '../../../../core/services/isar_service.dart';

class FrameRepository {
  final IsarService _isarService;

  FrameRepository(this._isarService);

  // Retrieves all Frame Model objects from the database
  Future<List<FrameModel>> getAll() async {
    try {
      final isar = await _isarService.db;
      final frames = await isar.frameModels.where().findAll();
      // Debug
      for (final f in frames) {
        debugPrint("Frame: ${f.name} has ${f.variants.length} variants");
      }

      return frames;
    } catch (e) {
      debugPrint("Error getting all Frame Model: $e");
      rethrow;
    }
  }

  // Retrieves a single Frame Model by id
  Future<FrameModel?> getById(Id id) async {
    try {
      final isar = await _isarService.db;
      final frame = await isar.frameModels.get(id);

      if (frame != null) {
        debugPrint(
          "Fetched Frame ${frame.name}, Variants: ${frame.variants.length}",
        );
      }

      return frame;
    } catch (e) {
      debugPrint("Error getting Frame Model by Id $id: $e");
      rethrow;
    }
  }

  // Retrieves a frame and eagerly loads its associated entry inventory entry
  Future<FrameModel?> getFrameWithInventory(Id id) async {
    try {
      final isar = await _isarService.db;
      final frame = await isar.frameModels.get(id);

      if (frame != null) {
        await frame.inventoryEntry.load();
        debugPrint("Frame ${frame.name} has ${frame.variants.length} variants");
      }
      return frame;
    } catch (e) {
      debugPrint("Error getting frame with inventory by Id $id: $e");
      rethrow;
    }
  }

  // Adds a new Frame Model to db
  Future<Id> add(FrameModel model) async {
    try {
      final isar = await _isarService.db;
      late Id newId;

      await isar.writeTxn(() async {
        newId = await isar.frameModels.put(model);

        final inventory = InventoryModel(
          quantityOnHand: 0,
          minStockLevel: 1,
          lastRestockDate: DateTime.now(),
        );

        await isar.inventoryModels.put(inventory);

        model.inventoryEntry.value = inventory;
        inventory.frame.value = model;

        // Save links both ways
        await model.inventoryEntry.save();
        await inventory.frame.save();

        await isar.activityModels.put(
          ActivityModel(
            type: ActivityType.newStockAdded,
            title: "New Frame added ${model.name}-${model.companyName}",
            subtitle: "QTY: ${model.inventoryEntry.value?.quantityOnHand}",
            time: DateTime.now()
          )
        );
      });

      debugPrint(
        "Added Frame ${model.name}, Variants: ${model.variants.length}",
      );

      return newId;
    } catch (e) {
      debugPrint("Error adding Frame Model: $e");
      rethrow;
    }
  }

  // Updates an existing FrameModel
  Future<void> update(FrameModel model) async {
    try {
      final isar = await _isarService.db;

      await isar.writeTxn(() async {
        await isar.frameModels.put(model);
      });

      debugPrint(
        "Updated Frame ${model.name}, Variants: ${model.variants.length}",
      );
    } catch (e) {
      debugPrint("Error updating Frame Model: $e");
      rethrow;
    }
  }

  /// Adds or replaces variants for a specific frame
  Future<void> updateVariants(
    Id frameId,
    List<FrameVariant> newVariants,
  ) async {
    try {
      final isar = await _isarService.db;
      final frame = await isar.frameModels.get(frameId);

      if (frame == null) {
        throw Exception("Frame not found for Id $frameId");
      }

      frame.variants
        ..clear()
        ..addAll(newVariants);

      await isar.writeTxn(() async {
        await isar.frameModels.put(frame);
      });

      debugPrint(
        "Updated Variants for Frame ${frame.name}. Now has ${frame.variants.length} variants",
      );
    } catch (e) {
      debugPrint("Error updating variants for Frame $frameId: $e");
      rethrow;
    }
  }

  // Deletes a Frame Model by Id
  Future<bool> delete(Id id) async {
    try {
      final isar = await _isarService.db;
      late bool deleted;

      await isar.writeTxn(() async {
        final frame = await isar.frameModels.get(id);

        if (frame != null) {
          // delete inventory if linked
          await frame.inventoryEntry.load();
          final inv = frame.inventoryEntry.value;
          if (inv != null) {
            await isar.inventoryModels.delete(inv.id);
          }
        }

        deleted = await isar.frameModels.delete(id);
      });

      debugPrint("Deleted Frame with Id $id → $deleted");
      return deleted;
    } catch (e) {
      debugPrint("Error while deleting a Frame Model: $e");
      rethrow;
    }
  }
}

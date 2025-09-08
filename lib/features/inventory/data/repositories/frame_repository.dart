// imports
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../models/frame_model.dart';
import '../../../../core/services/isar_service.dart';

class FrameRepository {
  final IsarService _isarService;

  FrameRepository(this._isarService);

  // Retrieves all Frame Model objects from the database
  Future<List<FrameModel>> getAll() async {
    try {
      final isar = await _isarService.db;
      return await isar.frameModels.where().findAll();
    } catch (e) {
      debugPrint("Error getting all Frame Model: $e");
      rethrow;
    }
  }

  // Retrieves a single Frame Model by id
  Future<FrameModel?> getById(Id id) async {
    try {
      final isar = await _isarService.db;
      return await isar.frameModels.get(id);
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
      });

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
    } catch (e) {
      debugPrint("Error updating Frame Model: $e");
      rethrow;
    }
  }

  // Deletes a Frame Model by Id
  Future<bool> delete(Id id) async {
    try {
      final isar = await _isarService.db;
      late bool deleted;

      await isar.writeTxn(() async {
        deleted = await isar.frameModels.delete(id);
      });
      return deleted;
    } catch (e) {
      debugPrint("Error while deleting a Frame Model: $e");
      rethrow;
    }
  }
}

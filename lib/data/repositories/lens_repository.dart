// imports
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../models/lens_model.dart';
import '../../services/isar_service.dart';

class LensRepository {
  final IsarService _isarService;

  LensRepository(this._isarService);

  // Retrieves all lenses from the database.
  Future<List<LensModel>> getAll() async {
    try {
      final isar = await _isarService.db;
      return await isar.lensModels.where().findAll();
    } catch (e) {
      debugPrint('Error getting all lenses: $e');
      rethrow;
    }
  }

  // Retrieves a single lens by its ID.
  Future<LensModel?> getById(Id id) async {
    try {
      final isar = await _isarService.db;
      return await isar.lensModels.get(id);
    } catch (e) {
      debugPrint("Error getting lens by Id $id: $e");
      rethrow;
    }
  }

  // Retrieves a lens and eagerly loads its associated inventory entry.
  Future<LensModel?> getLensWithInventoryId(Id id) async {
    try {
      final isar = await _isarService.db;
      final lens = await isar.lensModels.get(id);

      if (lens != null) {
        await lens.inventoryEntry.load();
      }
      return lens;
    } catch (e) {
      debugPrint("Error getting lens with inventory by Id $id: $e");
      rethrow;
    }
  }

  // Add a new lens to the db
  Future<Id> add(LensModel lens) async {
    try {
      final isar = await _isarService.db;
      late Id id;

      await isar.writeTxn(() async {
        id = await isar.lensModels.put(lens);
      });

      return id;
    } catch (e) {
      debugPrint("Error adding lens to database: $e");
      rethrow;
    }
  }

  // Update an existing lens model
  Future<void> update(LensModel lens) async {
    try {
      final isar = await _isarService.db;

      await isar.writeTxn(() async {
        await isar.lensModels.put(lens);
      });
    } catch (e) {
      debugPrint("Error update lens: $e");
      rethrow;
    }
  }

  // Delete a lens by its Id
  Future<bool> delete(Id id) async {
    try {
      final isar = await _isarService.db;
      late bool deleted;

      await isar.writeTxn(() async {
        deleted = await isar.lensModels.delete(id);
      });

      return deleted;
    } catch (e) {
      debugPrint("Error deleting lens: $e");
      rethrow;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/data/models/store_location_model.dart';
import 'package:osm/services/isar_service.dart';

class StoreLocationRepository {
  final IsarService _isarService;

  StoreLocationRepository(this._isarService);

  // Retrieves all store locations from the database.
  Future<List<StoreLocationModel>> getAll() async {
    try {
      final isar = await _isarService.db;
      return await isar.storeLocationModels.where().findAll();
    } catch (e) {
      debugPrint('Error getting all store locations: $e');
      rethrow;
    }
  }

  // Retrieves a single store location by its ID.
  Future<StoreLocationModel?> getById(Id id) async {
    try {
      final isar = await _isarService.db;
      return await isar.storeLocationModels.get(id);
    } catch (e) {
      debugPrint('Error getting store location by ID $id: $e');
      rethrow;
    }
  }

  // Retrieves a store location and eagerly loads its associated doctors and orders.
  Future<StoreLocationModel?> getStoreLocationWithRelations(Id id) async {
    try {
      final isar = await _isarService.db;
      final storeLocation = await isar.storeLocationModels.get(id);
      if (storeLocation != null) {
        await storeLocation.doctors.load();
        await storeLocation.orders.load();
      }
      return storeLocation;
    } catch (e) {
      debugPrint('Error getting store location with relations by ID $id: $e');
      rethrow;
    }
  }

  // Adds a new store location to the database.
  Future<Id> add(StoreLocationModel storeLocation) async {
    try {
      final isar = await _isarService.db;
      late Id newId;
      await isar.writeTxn(() async {
        newId = await isar.storeLocationModels.put(storeLocation);
      });
      return newId;
    } catch (e) {
      debugPrint('Error adding store location: $e');
      rethrow;
    }
  }

  // Updates an existing store location in the database.
  Future<void> update(StoreLocationModel storeLocation) async {
    try {
      final isar = await _isarService.db;
      await isar.writeTxn(() async {
        await isar.storeLocationModels.put(storeLocation);
      });
    } catch (e) {
      debugPrint('Error updating store location: $e');
      rethrow;
    }
  }

  // Deletes a store location by its ID.
  Future<bool> delete(Id id) async {
    try {
      final isar = await _isarService.db;
      late bool deleted;
      await isar.writeTxn(() async {
        deleted = await isar.storeLocationModels.delete(id);
      });
      return deleted;
    } catch (e) {
      debugPrint('Error deleting store location: $e');
      rethrow;
    }
  }
}

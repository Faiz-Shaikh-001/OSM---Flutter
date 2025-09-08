import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/features/doctors/data/models/doctor_model.dart';
import 'package:osm/core/services/isar_service.dart';

class DoctorRepository {
  final IsarService _isarService;

  DoctorRepository(this._isarService);

  // Retrieves all doctors from the database.
  Future<List<DoctorModel>> getAll() async {
    try {
      final isar = await _isarService.db;
      return await isar.doctorModels.where().findAll();
    } catch (e) {
      debugPrint('Error getting all doctors: $e');
      rethrow;
    }
  }

  // Retrieves a single doctor by their ID.
  Future<DoctorModel?> getById(Id id) async {
    try {
      final isar = await _isarService.db;
      return await isar.doctorModels.get(id);
    } catch (e) {
      debugPrint('Error getting doctor by ID $id: $e');
      rethrow;
    }
  }

  // Retrieves a doctor and eagerly loads their associated prescriptions.
  Future<DoctorModel?> getDoctorWithRelations(Id id) async {
    try {
      final isar = await _isarService.db;
      final doctor = await isar.doctorModels.get(id);
      if (doctor != null) {
        await doctor.prescriptions.load();
        await doctor.storeLocation.load(); // Load linked store location
      }
      return doctor;
    } catch (e) {
      debugPrint('Error getting doctor with relations by ID $id: $e');
      rethrow;
    }
  }

  // Adds a new doctor to the database.
  Future<Id> add(DoctorModel doctor) async {
    try {
      final isar = await _isarService.db;
      late Id newId;
      await isar.writeTxn(() async {
        newId = await isar.doctorModels.put(doctor);
      });
      return newId;
    } catch (e) {
      debugPrint('Error adding doctor: $e');
      rethrow;
    }
  }

  // Updates an existing doctor in the database.
  Future<void> update(DoctorModel doctor) async {
    try {
      final isar = await _isarService.db;
      await isar.writeTxn(() async {
        await isar.doctorModels.put(doctor);
      });
    } catch (e) {
      debugPrint('Error updating doctor: $e');
      rethrow;
    }
  }

  // Deletes a doctor by their ID.
  Future<bool> delete(Id id) async {
    try {
      final isar = await _isarService.db;
      late bool deleted;
      await isar.writeTxn(() async {
        deleted = await isar.doctorModels.delete(id);
      });
      return deleted;
    } catch (e) {
      debugPrint('Error deleting doctor: $e');
      rethrow;
    }
  }
}

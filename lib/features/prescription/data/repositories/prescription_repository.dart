import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/features/prescription/data/models/prescription_model.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/doctors/data/models/doctor_model.dart';
import 'package:osm/core/services/isar_service.dart';

class PrescriptionRepository {
  final IsarService _isarService;

  PrescriptionRepository(this._isarService);

  // Retrieves all prescriptions from the database.
  Future<List<PrescriptionModel>> getAll() async {
    try {
      final isar = await _isarService.db;
      final prescriptions = await isar.prescriptionModels.where().findAll();
      // Eagerly load customer and doctor for each prescription
      for (var p in prescriptions) {
        await p.customer.load(); // Load the customer link
        await p.doctor.load(); // Load the doctor link
      }
      return prescriptions;
    } catch (e) {
      debugPrint('Error getting all prescriptions: $e');
      rethrow;
    }
  }

  // Retrieves a single prescription by its ID.
  Future<PrescriptionModel?> getById(Id id) async {
    try {
      final isar = await _isarService.db;
      return await isar.prescriptionModels.get(id);
    } catch (e) {
      debugPrint('Error getting prescription by ID $id: $e');
      rethrow;
    }
  }

  // Retrieves a prescription and eagerly loads its associated customer, doctor, and orders.
  Future<PrescriptionModel?> getPrescriptionWithDetails(Id id) async {
    try {
      final isar = await _isarService.db;
      final prescription = await isar.prescriptionModels.get(id);
      if (prescription != null) {
        await prescription.customer.load();
        await prescription.doctor.load();
        await prescription.orders.load();
      }
      return prescription;
    } catch (e) {
      debugPrint('Error getting prescription with details by ID $id: $e');
      rethrow;
    }
  }

  // Adds a new prescription to the database and links it to an existing customer and doctor.
  Future<Id> add(
    PrescriptionModel prescription, {
    required CustomerModel customer,
    required DoctorModel doctor,
  }) async {
    try {
      final isar = await _isarService.db;
      late Id newId;
      await isar.writeTxn(() async {
        prescription.customer.value = customer;
        prescription.doctor.value = doctor;
        newId = await isar.prescriptionModels.put(prescription);
        await customer.prescriptions
            .save(); // Save the backlink on the customer
        await doctor.prescriptions.save(); // Save the backlink on the doctor
      });
      return newId;
    } catch (e) {
      debugPrint('Error adding prescription: $e');
      rethrow;
    }
  }

  // Updates an existing prescription in the database.
  Future<void> update(PrescriptionModel prescription) async {
    try {
      final isar = await _isarService.db;
      await isar.writeTxn(() async {
        await isar.prescriptionModels.put(prescription);
      });
    } catch (e) {
      debugPrint('Error updating prescription: $e');
      rethrow;
    }
  }

  // Deletes a prescription by its ID.
  Future<bool> delete(Id id) async {
    try {
      final isar = await _isarService.db;
      late bool deleted;
      await isar.writeTxn(() async {
        deleted = await isar.prescriptionModels.delete(id);
      });
      return deleted;
    } catch (e) {
      debugPrint('Error deleting prescription: $e');
      rethrow;
    }
  }

  // Retrieves prescriptions for a specific customer.
  Future<List<PrescriptionModel>> getPrescriptionsForCustomer(
    Id customerId,
  ) async {
    try {
      final isar = await _isarService.db;
      final prescriptions = await isar.prescriptionModels
          .filter()
          .customer((q) => q.idEqualTo(customerId))
          .findAll();
      // Eagerly load customer and doctor for each filtered prescription
      for (var p in prescriptions) {
        await p.customer.load();
        await p.doctor.load();
      }
      return prescriptions;
    } catch (e) {
      debugPrint('Error getting prescriptions for customer $customerId: $e');
      rethrow;
    }
  }

  // Retrieves prescriptions issued by a specific doctor.
  Future<List<PrescriptionModel>> getPrescriptionsByDoctor(Id doctorId) async {
    try {
      final isar = await _isarService.db;
      final prescriptions = await isar.prescriptionModels
          .filter()
          .doctor((q) => q.idEqualTo(doctorId))
          .findAll();
      // Eagerly load customer and doctor for each filtered prescription
      for (var p in prescriptions) {
        await p.customer.load();
        await p.doctor.load();
      }
      return prescriptions;
    } catch (e) {
      debugPrint('Error getting prescriptions by doctor $doctorId: $e');
      rethrow;
    }
  }

  Future<PrescriptionModel?> getLatestPrescriptionForCustomer(
    Id customerId,
  ) async {
    try {
      final isar = await _isarService.db;
      final latest = await isar.prescriptionModels
          .filter()
          .customer((q) => q.idEqualTo(customerId))
          .sortByPrescriptionDateDesc()
          .findFirst();
      if (latest != null) {
        await latest.customer.load();
        await latest.doctor.load();
        await latest.orders.load();
      }

      return latest;
    } catch (e) {
      debugPrint(
        'Error getting latest prescription for customer $customerId: $e',
      );
      rethrow;
    }
  }
}

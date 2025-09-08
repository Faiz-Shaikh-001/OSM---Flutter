// Imports
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

// Model Imports
import '../data/models/prescription_model.dart';
import '../../customer/data/customer_model.dart';
import '../../doctors/data/models/doctor_model.dart';

// Repository Imports
import '../data/repositories/prescription_repository.dart';

class PrescriptionViewModel extends ChangeNotifier {
  final PrescriptionRepository _prescriptionRepository;

  // State variables
  List<PrescriptionModel> _prescriptions = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters to expose data to UI
  List<PrescriptionModel> get prescriptions => _prescriptions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  PrescriptionViewModel(this._prescriptionRepository);

  /// Fetches all prescriptions.
  Future<void> loadPrescriptions() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _prescriptions = await _prescriptionRepository.getAll();
    } catch (e) {
      _errorMessage = 'Failed to load prescriptions: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Adds a new prescription.
  Future<void> addPrescription(
    PrescriptionModel prescription, {
    required CustomerModel customer,
    required DoctorModel doctor,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _prescriptionRepository.add(
        prescription,
        customer: customer,
        doctor: doctor,
      );
      await loadPrescriptions();
    } catch (e) {
      _errorMessage = 'Failed to add prescription: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Updates an existing prescription.
  Future<void> updatePrescription(PrescriptionModel prescription) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _prescriptionRepository.update(prescription);
      await loadPrescriptions();
    } catch (e) {
      _errorMessage = 'Failed to update prescription: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Deletes a prescription.
  Future<void> deletePrescription(Id id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final deleted = await _prescriptionRepository.delete(id);
      if (deleted) {
        await loadPrescriptions();
      } else {
        _errorMessage = 'Prescription not found or could not be deleted.';
      }
    } catch (e) {
      _errorMessage = 'Failed to delete prescription: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Retrieves prescriptions for a specific customer.
  Future<List<PrescriptionModel>> getPrescriptionsForCustomer(
    Id customerId,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    List<PrescriptionModel> customerPrescriptions = [];
    try {
      customerPrescriptions = await _prescriptionRepository
          .getPrescriptionsForCustomer(customerId);
    } catch (e) {
      _errorMessage =
          'Failed to get prescriptions for customer $customerId: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return customerPrescriptions;
  }
}

import 'package:flutter/foundation.dart'; // For ChangeNotifier
import 'package:osm/data/models/customer_model.dart';
import 'package:osm/data/repositories/customer_repository.dart';
import 'package:isar/isar.dart';

class CustomerViewModel extends ChangeNotifier {
  final CustomerRepository _customerRepository;

  // State variables
  List<CustomerModel> _customers = [];
  bool _isLoading = false;
  String? _errorMessage;
  List<CustomerModel> _searchResults = [];

  // Getters to expose state to the UI
  List<CustomerModel> get customers => _customers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<CustomerModel> get searchResults => _searchResults;

  CustomerViewModel(this._customerRepository);

  /// Fetches all customers from the repository and updates the state.
  Future<void> loadCustomers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notify UI that loading has started

    try {
      _customers = await _customerRepository.getAll();
    } catch (e) {
      _errorMessage = 'Failed to load customers: ${e.toString()}';
      _customers = []; // Clear customers on error
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify UI that loading has finished
    }
  }

  /// Adds a new customer via the repository and reloads the list.
  Future<void> addCustomer(CustomerModel customer) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _customerRepository.add(customer);
      await loadCustomers(); // Reload to reflect the new customer
    } catch (e) {
      _errorMessage = 'Failed to add customer: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Deletes a customer via the repository and reloads the list.
  Future<void> deleteCustomer(Id customerId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final deleted = await _customerRepository.delete(customerId);
      if (deleted) {
        await loadCustomers(); // Reload to reflect the deletion
      } else {
        _errorMessage = 'Customer not found or could not be deleted.';
      }
    } catch (e) {
      _errorMessage = 'Failed to delete customer: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search Customer using first name or last name or phone number
  Future<void> searchCustomers(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _searchResults = await _customerRepository.searchCustomers(query);
      debugPrint('View Model found ${_searchResults.length} customers.');
    } catch (e) {
      debugPrint('Error searching for customers: $e');
      _searchResults = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearchResults() {
    _searchResults = [];
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:osm/data/models/store_location_model.dart';
import 'package:osm/data/repositories/store_location_repository.dart';

class StoreLocationViewModel extends ChangeNotifier {
  final StoreLocationRepository _storeLocationRepository;

  List<StoreLocationModel> _storeLocations = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<StoreLocationModel> get storeLocations => _storeLocations;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  StoreLocationViewModel(this._storeLocationRepository);

  /// Fetches all store locations.
  Future<void> loadStoreLocations() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _storeLocations = await _storeLocationRepository.getAll();
    } catch (e) {
      _errorMessage = 'Failed to load store locations: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Adds a new store location.
  Future<void> addStoreLocation(StoreLocationModel storeLocation) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _storeLocationRepository.add(storeLocation);
      await loadStoreLocations();
    } catch (e) {
      _errorMessage = 'Failed to add store location: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Updates an existing store location.
  Future<void> updateStoreLocation(StoreLocationModel storeLocation) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _storeLocationRepository.update(storeLocation);
      await loadStoreLocations();
    } catch (e) {
      _errorMessage = 'Failed to update store location: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Deletes a store location.
  Future<void> deleteStoreLocation(Id id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final deleted = await _storeLocationRepository.delete(id);
      if (deleted) {
        await loadStoreLocations();
      } else {
        _errorMessage = 'Store location not found or could not be deleted.';
      }
    } catch (e) {
      _errorMessage = 'Failed to delete store location: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

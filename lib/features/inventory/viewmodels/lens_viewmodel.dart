import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import '../data/models/lens_model.dart';
import '../data/repositories/lens_repository.dart';

class LensViewmodel extends ChangeNotifier {
  final LensRepository _lensRepository;

  List<LensModel> _lens = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<LensModel> get lens => _lens;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  LensViewmodel(this._lensRepository);

  // Load all lens from the repository
  Future<void> loadLenses() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _lens = await _lensRepository.getAll();
    } catch (e) {
      _errorMessage = 'Failed to load lenses: ${e.toString()}';
      _lens = [];
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new lens via the repository
  Future<void> addLens(LensModel lens) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _lensRepository.add(lens);
      await loadLenses();
    } catch (e) {
      _errorMessage = 'Failed to add lens: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update a lens via the repository
  Future<void> update(LensModel lens) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _lensRepository.update(lens);
      await loadLenses();
    } catch (e) {
      _errorMessage = 'Failed to update lens: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete a lens by ID via the repository
  Future<void> deleteLens(Id id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final deleted = await _lensRepository.delete(id);

      if (deleted) {
        await loadLenses();
      } else {
        _errorMessage = 'Lens not found or could not be deleted';
      }
    } catch (e) {
      _errorMessage = 'Failed to delete lens: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

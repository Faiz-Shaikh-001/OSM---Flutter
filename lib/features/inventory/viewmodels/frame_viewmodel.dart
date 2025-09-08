import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import '../data/models/frame_model.dart';
import '../data/repositories/frame_repository.dart';

class FrameViewmodel extends ChangeNotifier {
  final FrameRepository _frameRepository;

  List<FrameModel> _frames = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<FrameModel> get frames => _frames;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  FrameViewmodel(this._frameRepository);

  // Load all frames from the repository
  Future<void> loadFrames() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _frames = await _frameRepository.getAll();
    } catch (e) {
      _errorMessage = 'Failed to load frames: ${e.toString()}';
      _frames = [];
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new frame via the repository
  Future<void> addFrame(FrameModel frame) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _frameRepository.add(frame);
      await loadFrames();
    } catch (e) {
      _errorMessage = 'Failed to add frame: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Updates an existing frame via the repository
  Future<void> updateFrame(FrameModel frame) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _frameRepository.update(frame);
      await loadFrames();
    } catch (e) {
      _errorMessage = 'Failed to update frame: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete a frame by ID via the repository
  Future<void> deleteFrame(Id id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final deleted = await _frameRepository.delete(id);
      if (deleted) {
        await loadFrames();
      } else {
        _errorMessage = 'Frame not found or could not be deleted.';
      }
    } catch (e) {
      _errorMessage = 'Failed to delete frame: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:osm/features/dashboard/presentation/data/models/activity_repository.dart';
import 'package:osm/features/dashboard/presentation/data/models/recent_activities.dart';

class ActivityViewModel extends ChangeNotifier {
  final ActivityRepository _repo;

  List<ActivityModel> _activities = [];
  List<ActivityModel> get activities => _activities;

  ActivityViewModel(this._repo) {
    _repo.watchChanges().listen((_) => refresh());
    refresh();
  }

  Future<void> refresh() async {
    _activities = await _repo.getAll();
    notifyListeners();
  }
}

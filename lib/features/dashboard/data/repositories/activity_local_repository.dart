import 'package:isar/isar.dart';
import 'package:osm/features/dashboard/data/models/activity_model.dart';
import 'package:osm/features/dashboard/domain/entities/activity.dart';

class ActivityLocalRepository {
  const ActivityLocalRepository();

  // Save an activity
  Future<void> log(ActivityModel model, {required Isar isar}) async {
    await isar.activityModels.put(model);
  }

  // Get recent activites
  Stream<List<Activity>> watchRecent({int limit = 20, required Isar isar}) {
    return isar.activityModels
        .where()
        .sortByOccurredAtDesc()
        .watch(fireImmediately: true)
        .map((models) => models.map((model) => model.toEntity()).toList());
  }
}

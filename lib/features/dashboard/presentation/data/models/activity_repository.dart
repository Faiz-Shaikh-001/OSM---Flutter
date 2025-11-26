import 'package:isar/isar.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/dashboard/presentation/data/models/recent_activities.dart';

class ActivityRepository {
  final IsarService _isarService;

  ActivityRepository(this._isarService);

  Future<void> log(ActivityModel activity, {Isar? isar}) async {
    final db = isar ?? await _isarService.db;

    if (isar != null) {
      await db.activityModels.put(activity);
    } else {
      await db.writeTxn(() async {
        await db.activityModels.put(activity);
      });
    }
  }

  Future<List<ActivityModel>> getAll() async {
    final isar = await _isarService.db;
    return await isar.activityModels.where().sortByTimeDesc().findAll();
  }

  Stream<void> watchChanges() async* {
    final isar = await _isarService.db;
    yield* isar.activityModels.watchLazy();
  }
}

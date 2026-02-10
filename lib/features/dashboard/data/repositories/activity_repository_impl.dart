import 'package:osm/core/either.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/dashboard/data/repositories/activity_local_repository.dart';
import 'package:osm/features/dashboard/domain/entities/activity.dart';
import 'package:osm/features/dashboard/domain/failures/activity_failure.dart';
import 'package:osm/features/dashboard/domain/repositories/activity_repository.dart';
import 'package:osm/features/dashboard/domain/success/activity_success.dart';

class ActivityRepositoryImpl implements ActivityRepository{
  final IsarService _isarService;
  final ActivityLocalRepository _localRepository;
  
  ActivityRepositoryImpl(this._isarService, this._localRepository);

  @override
  Future<Either<ActivityFailure, ActivitySuccess>> log(Activity activity) async {
    try{
      final isar = await _isarService.db;
      _localRepository.log(activity, isar: isar);
      return const Right(ActivitySuccess());
    } catch (e) {
      return const Left(ActivityStorageFailure("Failed to save activity"));
    }
  }

  @override
  Stream<List<Activity>> watchRecent({int limit = 20}) async* {
    try {
      final isar = await _isarService.db;
      yield* _localRepository.watchRecent(limit: limit, isar: isar);
    } catch (e) {
      yield <Activity>[];
    }
  }
}
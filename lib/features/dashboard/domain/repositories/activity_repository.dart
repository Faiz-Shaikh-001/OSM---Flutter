import 'package:osm/core/either.dart';
import 'package:osm/features/dashboard/domain/entities/activity.dart';
import 'package:osm/features/dashboard/domain/failures/activity_failure.dart';
import 'package:osm/features/dashboard/domain/success/activity_success.dart';

abstract class ActivityRepository {
  // Save a new activity
  Future<Either<ActivityFailure, ActivitySuccess>> log(Activity activity);

  // Watch recent activites
  Stream<List<Activity>> watchRecent({int limit});
}

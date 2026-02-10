import 'package:osm/core/either.dart';
import 'package:osm/features/dashboard/domain/entities/activity.dart';
import 'package:osm/features/dashboard/domain/failures/activity_failure.dart';
import 'package:osm/features/dashboard/domain/repositories/activity_repository.dart';
import 'package:osm/features/dashboard/domain/success/activity_success.dart';

class SaveActivity {
  final ActivityRepository repository;
  SaveActivity(this.repository);

  Future<Either<ActivityFailure, ActivitySuccess>> call(Activity activity) {
    return repository.log(activity);
  }
}

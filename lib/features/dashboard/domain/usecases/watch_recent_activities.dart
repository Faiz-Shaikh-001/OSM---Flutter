import 'package:osm/features/dashboard/domain/entities/activity.dart';
import 'package:osm/features/dashboard/domain/repositories/activity_repository.dart';

class WatchRecentActivities {
  final ActivityRepository repository;

  WatchRecentActivities(this.repository);

  Stream<List<Activity>> call({int limit = 20}) {
    return repository.watchRecent(limit: limit);
  }
}

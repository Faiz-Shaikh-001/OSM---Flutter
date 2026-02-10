import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/features/dashboard/domain/entities/activity.dart';
import 'package:osm/features/dashboard/domain/failures/activity_failure.dart';
import 'package:osm/features/dashboard/domain/usecases/save_activity.dart';
import 'package:osm/features/dashboard/domain/usecases/watch_recent_activities.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final SaveActivity saveActivity;
  final WatchRecentActivities watchRecentActivities;

  StreamSubscription<List<Activity>>? _subscription;

  ActivityBloc({
    required this.saveActivity,
    required this.watchRecentActivities,
  }) : super(ActivityInitial()) {
    on<SaveActivityEvent>(_onSaveActivity);
    on<WatchActivitiesEvent>(_onWatchActivities);
  }
  Future<void> _onSaveActivity(
    SaveActivityEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());

    final result = await saveActivity(event.activity);

    result.fold(
      (failure) {
        emit(ActivityError(_mapFailureToMessage(failure)));
      }, 
      ( _ ) {
        // Success -> DO NOTHING
      }
    );
  }

    Future<void> _onWatchActivities(
    WatchActivitiesEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());

    await _subscription?.cancel();

    _subscription = watchRecentActivities(limit: event.limit).listen(
      (activities) {
        emit(ActivityLoaded(activities));
      },
      onError: (_) {
        emit(const ActivityError('Failed to load activities'));
      },
    );
  }

  
  String _mapFailureToMessage(ActivityFailure failure) {
    if (failure is ActivityStorageFailure) {
      return 'Unable to save activity';
    }
    return 'Unexpected error occurred';
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

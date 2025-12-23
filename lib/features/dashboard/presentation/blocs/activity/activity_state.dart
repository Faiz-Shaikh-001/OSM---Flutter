part of 'activity_bloc.dart';

@immutable
sealed class ActivityState {
  const ActivityState();
}

// Initial idle state
final class ActivityInitial extends ActivityState {}

// Loading / waiting state
final class ActivityLoading extends ActivityState {}

// Activities loaded successfully
final class ActivityLoaded extends ActivityState {
  final List<Activity> activities;

  const ActivityLoaded(this.activities);
}

// Error state
final class ActivityError extends ActivityState {
  final String message;

  const ActivityError(this.message);
}

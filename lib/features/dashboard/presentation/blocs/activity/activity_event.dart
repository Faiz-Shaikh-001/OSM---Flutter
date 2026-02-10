part of 'activity_bloc.dart';

@immutable
sealed class ActivityEvent {
  const ActivityEvent();
}

// Triggered when new activity needs to be saved
class SaveActivityEvent extends ActivityEvent {
  final Activity activity;

  const SaveActivityEvent(this.activity);
}

// Triggered when dashboard starts / opens
class WatchActivitiesEvent extends ActivityEvent {
  final int limit;

  const WatchActivitiesEvent({this.limit = 20});
}

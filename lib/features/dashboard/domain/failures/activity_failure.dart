abstract class ActivityFailure {
  final String message;
  const ActivityFailure(this.message);
}

class ActivityStorageFailure extends ActivityFailure {
  const ActivityStorageFailure(String message) : super(message);
}

class ActivityUnknownFailure extends ActivityFailure {
  const ActivityUnknownFailure(String message) : super(message);
}

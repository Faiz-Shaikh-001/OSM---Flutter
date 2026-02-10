abstract class ActivityFailure {
  final String message;
  const ActivityFailure(this.message);
}

class ActivityStorageFailure extends ActivityFailure {
  const ActivityStorageFailure(super.message);
}

class ActivityUnknownFailure extends ActivityFailure {
  const ActivityUnknownFailure(super.message);
}

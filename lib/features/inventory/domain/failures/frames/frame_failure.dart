abstract class FrameFailure {
  const FrameFailure();
}

class FrameNotFoundFailure extends FrameFailure {
  const FrameNotFoundFailure();
}

class FrameValidationFailure extends FrameFailure {
  final String message;
  const FrameValidationFailure(this.message);
}

class FrameStorageFailure extends FrameFailure {
  final String message;
  const FrameStorageFailure(this.message);
}

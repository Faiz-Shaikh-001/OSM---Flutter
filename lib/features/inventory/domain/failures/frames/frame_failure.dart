abstract class FrameFailure {
  final String message;
  const FrameFailure(this.message);
}

class FrameNotFoundFailure extends FrameFailure {
  const FrameNotFoundFailure() : super("Frame not found");
}

class FrameValidationFailure extends FrameFailure {
  const FrameValidationFailure(super.message);
}

class FrameConflictFailure extends FrameFailure {
  const FrameConflictFailure(super.message);
}


class FrameStorageFailure extends FrameFailure {
  const FrameStorageFailure([super.message = 'Failed to save frame']);
}

class FrameVariantFailure extends FrameFailure {
  const FrameVariantFailure(super.message);
}

class FrameUnexpectedFailure extends FrameFailure {
  const FrameUnexpectedFailure(super.message);
}


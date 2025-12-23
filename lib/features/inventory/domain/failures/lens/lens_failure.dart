abstract class LensFailure {
  const LensFailure();
}

class LensNotFoundFailure extends LensFailure {
  const LensNotFoundFailure();
}

class LensValidationFailure extends LensFailure {
  final String message;
  const LensValidationFailure(this.message);
}

class LensStorageFailure extends LensFailure {
  final String message;
  const LensStorageFailure(this.message);
}

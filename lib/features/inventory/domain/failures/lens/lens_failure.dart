abstract class LensFailure {
  final String message;
  const LensFailure(this.message);
}


class LensNotFoundFailure extends LensFailure {
  const LensNotFoundFailure()
      : super('Lens not found');
}


class LensValidationFailure extends LensFailure {
  const LensValidationFailure(super.message);
}


class LensConflictFailure extends LensFailure {
  const LensConflictFailure(super.message);
}

class LensStorageFailure extends LensFailure {
  const LensStorageFailure([
    super.message = 'Failed to save lens',
  ]);
}

class LensUnexpectedFailure extends LensFailure {
  const LensUnexpectedFailure([
    super.message = 'Unexpected lens failure',
  ]);
}

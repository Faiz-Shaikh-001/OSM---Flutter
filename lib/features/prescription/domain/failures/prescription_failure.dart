abstract class PrescriptionFailure {
  final String message;
  const PrescriptionFailure(this.message);
}

class PrescriptionNotFoundFailure extends PrescriptionFailure {
  const PrescriptionNotFoundFailure()
      : super('Prescription not found');
}

class InvalidPrescriptionFailure extends PrescriptionFailure {
  const InvalidPrescriptionFailure(super.message);
}

class PrescriptionPersistenceFailure extends PrescriptionFailure {
  const PrescriptionPersistenceFailure()
      : super('Failed to save prescription');
}

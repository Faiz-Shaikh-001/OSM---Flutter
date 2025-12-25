abstract class PrescriptionFailure {
  final String message;
  const PrescriptionFailure(this.message);
}

class PrescriptionNotFoundFailure extends PrescriptionFailure {
  const PrescriptionNotFoundFailure() : super('Prescription not found');
}

class InvalidPrescriptionFailure extends PrescriptionFailure {
  const InvalidPrescriptionFailure(super.message);
}

class PrescriptionStorageFailure extends PrescriptionFailure {
  const PrescriptionStorageFailure() : super('Failed to store prescription');
}

class PrescriptionValidationFailure extends PrescriptionFailure {
  const PrescriptionValidationFailure(super.message);
}

class PrescriptionInUseFailure extends PrescriptionFailure {
  const PrescriptionInUseFailure()
    : super('Prescription is already used in an order');
}

class PrescriptionCustomerNotFoundFailure extends PrescriptionFailure {
  const PrescriptionCustomerNotFoundFailure(super.message);
}

class PrescriptionDoctorNotFoundFailure extends PrescriptionFailure {
  const PrescriptionDoctorNotFoundFailure() : super("Doctor not found for prescription");
}

class PrescriptionUnknownFailure extends PrescriptionFailure {
  const PrescriptionUnknownFailure() : super("Unexpected prescription error.");
}

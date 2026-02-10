abstract class DoctorFailure {
  final String message;
  const DoctorFailure(this.message);
}

class DoctorNotFoundFailure extends DoctorFailure {
  const DoctorNotFoundFailure()
      : super('Doctor not found');
}

class DoctorAlreadyExistsFailure extends DoctorFailure {
  const DoctorAlreadyExistsFailure()
      : super('Doctor already exists');
}

class DoctorPersistenceFailure extends DoctorFailure {
  const DoctorPersistenceFailure()
      : super('Failed to persist doctor');
}

class InvalidDoctorFailure extends DoctorFailure {
  const InvalidDoctorFailure(super.message);
}

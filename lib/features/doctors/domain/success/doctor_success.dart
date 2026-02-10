abstract class DoctorSuccess {
  final String message;
  const DoctorSuccess(this.message);
}

class DoctorUpdatedSuccess extends DoctorSuccess {
  const DoctorUpdatedSuccess()
      : super('Doctor updated successfully');
}

class DoctorDeactivatedSuccess extends DoctorSuccess {
  const DoctorDeactivatedSuccess()
      : super('Doctor deactivated successfully');
}

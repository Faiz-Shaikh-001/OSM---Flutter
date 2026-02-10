part of 'edit_doctor_bloc.dart';

@immutable
abstract class EditDoctorEvent {}

class UpdateDoctorEvent extends EditDoctorEvent {
  final Doctor doctor;
  UpdateDoctorEvent(this.doctor);
}

class DeactivateDoctorEvent extends EditDoctorEvent {
  final DoctorId doctorId;
  DeactivateDoctorEvent(this.doctorId);
}

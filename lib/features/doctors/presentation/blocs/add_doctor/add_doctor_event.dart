part of 'add_doctor_bloc.dart';

@immutable
sealed class AddDoctorEvent {}

class SubmitDoctor extends AddDoctorEvent {
  final Doctor doctor;

  SubmitDoctor(this.doctor);
}
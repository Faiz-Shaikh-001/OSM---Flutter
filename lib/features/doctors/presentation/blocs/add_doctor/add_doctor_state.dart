part of 'add_doctor_bloc.dart';

@immutable
sealed class AddDoctorState {}

final class AddDoctorInitial extends AddDoctorState {}

class AddDoctorSubmitting extends AddDoctorState {}

class AddDoctorSuccess extends AddDoctorState {
  final DoctorId doctorId;

  AddDoctorSuccess(this.doctorId);
}

class AddDoctorFailure extends AddDoctorState {
  final String message;

  AddDoctorFailure(this.message);
}
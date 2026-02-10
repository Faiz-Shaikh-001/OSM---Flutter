part of 'doctor_bloc.dart';

@immutable
sealed class DoctorState {}

final class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {
  final List<Doctor> doctors;

  DoctorLoaded(this.doctors);
}

class DoctorEmpty extends DoctorState {}

class DoctorError extends DoctorState {
  final String message;

  DoctorError(this.message);
}
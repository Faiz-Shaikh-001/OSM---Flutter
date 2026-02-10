part of 'doctor_details_bloc.dart';

@immutable
abstract class DoctorDetailsState {}

class DoctorDetailsInitial extends DoctorDetailsState {}

class DoctorDetailsLoading extends DoctorDetailsState {}

class DoctorDetailsLoaded extends DoctorDetailsState {
  final Doctor doctor;

  DoctorDetailsLoaded(this.doctor);
}

class DoctorDetailsError extends DoctorDetailsState {
  final String message;

  DoctorDetailsError(this.message);
}

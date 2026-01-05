part of 'doctor_details_bloc.dart';

@immutable
abstract class DoctorDetailsEvent {}

class LoadDoctorDetails extends DoctorDetailsEvent {
  final DoctorId doctorId;

  LoadDoctorDetails(this.doctorId);
}

part of 'edit_doctor_bloc.dart';

@immutable
abstract class EditDoctorState {}

class EditDoctorInitial extends EditDoctorState {}

class EditDoctorSubmitting extends EditDoctorState {}

class EditDoctorSuccess extends EditDoctorState {}

class EditDoctorDeactivated extends EditDoctorState {}

class EditDoctorFailure extends EditDoctorState {
  final String message;
  EditDoctorFailure(this.message);
}

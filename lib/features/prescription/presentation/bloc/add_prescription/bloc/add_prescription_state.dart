part of 'add_prescription_bloc.dart';

@immutable
sealed class AddPrescriptionState {}

final class AddPrescriptionInitial extends AddPrescriptionState {}

class AddPrescriptionIdle extends AddPrescriptionState {}

class AddPrescriptionSubmitting extends AddPrescriptionState {}

class AddPrescriptionSuccess extends AddPrescriptionState {}
 
class AddPrescriptionFailure extends AddPrescriptionState {
  final String message;
  AddPrescriptionFailure(this.message);
}

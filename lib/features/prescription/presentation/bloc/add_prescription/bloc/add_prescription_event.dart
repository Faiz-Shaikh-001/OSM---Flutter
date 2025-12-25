part of 'add_prescription_bloc.dart';

@immutable
sealed class AddPrescriptionEvent {}

class SubmitPrescription extends AddPrescriptionEvent {
  final Prescription prescription;
  final CustomerId customerId;
  SubmitPrescription(this.prescription, this.customerId);
}
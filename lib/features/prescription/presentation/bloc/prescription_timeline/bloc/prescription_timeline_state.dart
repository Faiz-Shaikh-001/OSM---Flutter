part of 'prescription_timeline_bloc.dart';

@immutable
sealed class PrescriptionTimelineState {}

final class PrescriptionTimelineInitial extends PrescriptionTimelineState {}

class PrescriptionTimelineLoading extends PrescriptionTimelineState {}

class PrescriptionTimelineLoaded extends PrescriptionTimelineState {
  final List<Prescription> prescriptions;
  PrescriptionTimelineLoaded(this.prescriptions);
}

class PrescriptionTimelineError extends PrescriptionTimelineState {
  final String message;
  PrescriptionTimelineError(this.message);
}
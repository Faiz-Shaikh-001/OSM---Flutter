part of 'prescription_timeline_bloc.dart';

@immutable
sealed class PrescriptionTimelineEvent {}

class LoadPrescriptionTimeline extends PrescriptionTimelineEvent {
  final CustomerId customerId;
  LoadPrescriptionTimeline(this.customerId);
}

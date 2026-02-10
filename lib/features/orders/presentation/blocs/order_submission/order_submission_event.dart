part of 'order_submission_bloc.dart';

sealed class OrderSubmissionEvent extends Equatable {
  const OrderSubmissionEvent();

  @override
  List<Object> get props => [];
}

final class SubmitOrderDraft extends OrderSubmissionEvent {
  final OrderDraft draft;

  const SubmitOrderDraft(this.draft);

  @override
  List<Object> get props => [draft];
}

class ResetOrderSubmission extends OrderSubmissionEvent {}

class AddOrderPayment extends OrderSubmissionEvent {
  final Order order;
  final Payment payment;

  const AddOrderPayment({required this.order, required this.payment});
}

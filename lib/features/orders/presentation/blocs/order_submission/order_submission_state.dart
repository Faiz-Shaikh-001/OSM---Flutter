part of 'order_submission_bloc.dart';

sealed class OrderSubmissionState extends Equatable {
  const OrderSubmissionState();
  
  @override
  List<Object> get props => [];
}

final class OrderSubmissionInitial extends OrderSubmissionState {}

class OrderSubmissionLoading extends OrderSubmissionState {}

class OrderSubmissionSuccess extends OrderSubmissionState {
  final Order order;

  const OrderSubmissionSuccess(this.order);

  @override
  List<Object> get props => [order];
}

class OrderSubmissionFailure extends OrderSubmissionState {
  final OrderFailure failure;

  const OrderSubmissionFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
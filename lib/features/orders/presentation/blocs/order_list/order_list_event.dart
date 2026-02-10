part of 'order_list_bloc.dart';

sealed class OrderListEvent extends Equatable {
  const OrderListEvent();

  @override
  List<Object> get props => [];
}

class OrderListStarted extends OrderListEvent {}

class OrderDeleted extends OrderListEvent {
  final OrderId orderId;

  const OrderDeleted(this.orderId);

  @override
  List<Object> get props => [orderId];
}

class _OrderListUpdated extends OrderListEvent {
  final List<Order> orders;

  const _OrderListUpdated(this.orders);

  @override
  List<Object> get props => [orders];
}

class _OrderListStreamFailure extends OrderListEvent {
  final String message;

  const _OrderListStreamFailure(this.message);

  @override
  List<Object> get props => [message];
}
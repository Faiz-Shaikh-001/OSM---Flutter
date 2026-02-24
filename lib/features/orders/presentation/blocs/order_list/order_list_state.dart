part of 'order_list_bloc.dart';

sealed class OrderListState extends Equatable {
  const OrderListState();
  
  @override
  List<Object> get props => [];
}

final class OrderListInitial extends OrderListState {}

final class OrderListLoading extends OrderListState {}

final class OrderListSuccess extends OrderListState {
  final List<Order> orders;

  const OrderListSuccess(this.orders);

  @override
  List<Object> get props => [orders];
}

final class OrderListFailure extends OrderListState {
  final String message;

  const OrderListFailure(this.message);

  @override
  List<Object> get props => [message];
}


final class OrderListOperationSuccess extends OrderListState {
  final String message;
  final List<Order> currentOrders;

  const OrderListOperationSuccess(this.message, this.currentOrders);

  @override
  List<Object> get props => [message, currentOrders];
}
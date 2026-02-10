import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:osm/features/orders/domain/usecases/delete_order.dart';
import 'package:osm/features/orders/domain/usecases/watch_orders.dart';

part 'order_list_event.dart';
part 'order_list_state.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  final WatchOrders _watchOrders;
  final DeleteOrder _deleteOrder;

  StreamSubscription? _ordersSubscription;

  OrderListBloc({
    required WatchOrders watchOrders,
    required DeleteOrder deleteOrder,
  }) : _watchOrders = watchOrders,
       _deleteOrder = deleteOrder,
       super(OrderListInitial()) {
    on<OrderListStarted>(_onStarted);
    on<OrderDeleted>(_onDeleted);
    on<_OrderListUpdated>(_onUpdated);
    on<_OrderListStreamFailure>(_onStreamFailure);
  }

  Future<void> _onStarted(
    OrderListStarted event,
    Emitter<OrderListState> emit,
  ) async {
    emit(OrderListLoading());

    await _ordersSubscription?.cancel();

    _ordersSubscription = _watchOrders().listen(
      (result) {
        result.fold(
          (failure) => add(_OrderListStreamFailure(failure.message)),
          (orders) => add(_OrderListUpdated(orders)),
        );
      },
      onError: (error) {
        add(_OrderListStreamFailure(error.toString()));
      },
    );
  }

  void _onUpdated(_OrderListUpdated event, Emitter<OrderListState> emit) {
    emit(OrderListSuccess(event.orders));
  }

  void _onStreamFailure(
    _OrderListStreamFailure event,
    Emitter<OrderListState> emit,
  ) {
    emit(OrderListFailure(event.message));
  }

  Future<void> _onDeleted(
    OrderDeleted event,
    Emitter<OrderListState> emit,
  ) async {
    final result = await _deleteOrder(event.orderId);

    result.fold((failure) => emit(OrderListFailure(failure.message)), (
      deletedOrder,
    ) {
      if (state is OrderListSuccess) {
        final currentList = (state as OrderListSuccess).orders;
        emit(
          OrderListOperationSuccess(
            "Order #${deletedOrder.id.value} deleted",
            currentList,
          ),
        );
        emit(OrderListSuccess(currentList));
      }
    });
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}

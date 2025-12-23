import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:osm/features/orders/domain/entities/order_item.dart';
import 'package:osm/features/orders/domain/entities/order_enums.dart';
import 'package:osm/features/orders/domain/entities/payment.dart';
import 'package:osm/features/orders/domain/usecases/add_payment.dart';
import 'package:osm/features/orders/domain/usecases/create_order.dart';
import 'package:osm/features/orders/domain/usecases/create_order_from_draft.dart';
import 'package:osm/features/orders/domain/usecases/delete_order.dart';
import 'package:osm/features/orders/domain/usecases/get_orders.dart';
import 'package:osm/features/orders/domain/usecases/update_order_status.dart';
import 'package:osm/features/orders/domain/value_objects/order_draft.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateOrderFromDraft createOrderFromDraft;
  final GetOrders getOrders;
  final DeleteOrder deleteOrder;
  final UpdateOrderStatus updateOrderStatus;
  final AddPayment addPayment;

  OrderDraft _draft = OrderDraft.empty();
  int _step = 1;

  OrderBloc({
    required this.createOrderFromDraft,
    required this.getOrders,
    required this.deleteOrder,
    required this.updateOrderStatus,
    required this.addPayment,
  }) : super(const OrderInitial()) {

    on<StartOrderDraft>(_onStartDraft);
    on<SetOrderCustomer>(_onSetCustomer);
    on<SetOrderItems>(_onSetItems);
    on<AddDraftPayment>(_onAddDraftPayment);
    on<SubmitOrderDraft>(_onSubmitDraft);
    on<ResetOrderDraft>(_onResetDraft);

    on<LoadOrdersEvent>(_onLoadOrders);
    on<DeleteOrderEvent>(_onDeleteOrder);
    on<UpdateOrderStatusEvent>(_onUpdateStatus);
    on<AddPaymentToOrder>(_onAddPaymentToOrder);
  }

  void _emitDraft(Emitter<OrderState> emit) {
    emit(OrderDrafting(draft: _draft, currentStep: _step));
  }

  void _onStartDraft(StartOrderDraft event, Emitter<OrderState> emit) {
    _draft = OrderDraft.empty();
    _step = 1;
    _emitDraft(emit);
  }

  void _onSetCustomer(SetOrderCustomer event, Emitter<OrderState> emit) {
    _draft = _draft.withCustomer(CustomerId(event.customer.id!));
    _step = 2;
    _emitDraft(emit);
  }

  void _onSetItems(SetOrderItems event, Emitter<OrderState> emit) {
    _draft = _draft.withItems(event.items);
    _step = 3;
    _emitDraft(emit);
  }

  void _onAddDraftPayment(AddDraftPayment event, Emitter<OrderState> emit) {
    _draft = _draft.withPayment(event.payment);
    _emitDraft(emit);
  }

  Future<void> _onSubmitDraft(
    SubmitOrderDraft event,
    Emitter<OrderState> emit,
  ) async {
    if (!_draft.isComplete) {
      emit(const OrderError('Order is incomplete'));
      return;
    }

    emit(OrderSubmitting());

    final result = await createOrderFromDraft(_draft);

    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (order) {
        emit(OrderSuccess(order));
        add(const LoadOrdersEvent());
      },
    );
  }

  void _onResetDraft(ResetOrderDraft event, Emitter<OrderState> emit) {
    _draft = OrderDraft.empty();
    _step = 1;
    emit(const OrderInitial());
  }

  Future<void> _onLoadOrders(
    LoadOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderLoading());

    final result = await getOrders();

    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (orders) => emit(OrderLoaded(orders)),
    );
  }

  Future<void> _onDeleteOrder(
    DeleteOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    final result = await deleteOrder(event.orderId);

    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (_) => add(const LoadOrdersEvent()),
    );
  }

  Future<void> _onUpdateStatus(
    UpdateOrderStatusEvent event,
    Emitter<OrderState> emit,
  ) async {
    final result =
        await updateOrderStatus(event.orderId, event.status);

    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (_) => add(const LoadOrdersEvent()),
    );
  }

  Future<void> _onAddPaymentToOrder(
    AddPaymentToOrder event,
    Emitter<OrderState> emit,
  ) async {
    final result =
        await addPayment(event.orderId, event.payment);

    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (_) => add(const LoadOrdersEvent()),
    );
  }
}

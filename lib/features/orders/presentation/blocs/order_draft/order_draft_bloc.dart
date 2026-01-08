import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/orders/domain/entities/order_item.dart';
import 'package:osm/features/orders/domain/entities/payment.dart';
import 'package:osm/features/orders/domain/value_objects/order_draft.dart';

part 'order_draft_event.dart';
part 'order_draft_state.dart';

class OrderDraftBloc extends Bloc<OrderDraftEvent, OrderDraftState> {
  OrderDraftBloc() : super(OrderDraftState.initial()) {
    on<CustomerSelected>(_onCustomerSelected);
    on<CustomerRemoved>(_onCustomerRemoved);
    on<PrescriptionSelected>(_onPrescriptionSelected);
    on<PrescriptionCleared>(_onPrescriptionCleared);
    on<StoreSelected>(_onStoreSelected);
    on<ItemAdded>(_onItemAdded);
    on<ItemRemoved>(_onItemRemoved);
    on<PaymentAdded>(_onPaymentAdded);
    on<OrderDraftReset>(_onOrderDraftReset);
  }

  void _onCustomerSelected(
    CustomerSelected event,
    Emitter<OrderDraftState> emit,
  ) {
    final updatedDraft = state.draft.withCustomer(event.customerId);
    emit(OrderDraftState(updatedDraft));
  }

  void _onCustomerRemoved(
    CustomerRemoved event,
    Emitter<OrderDraftState> emit,
  ) {
    final updatedDraft = OrderDraft(
      storeLocationId: state.draft.storeLocationId,
      items: state.draft.items,
      payment: state.draft.payment,
    );

    emit(OrderDraftState(updatedDraft));
  }

  void _onPrescriptionSelected(
    PrescriptionSelected event,
    Emitter<OrderDraftState> emit,
  ) {
    final updatedDraft = state.draft.withPrescription(event.prescriptionId);
    emit(OrderDraftState(updatedDraft));
  }

  void _onPrescriptionCleared(
    PrescriptionCleared event,
    Emitter<OrderDraftState> emit,
  ) {
    final updatedDraft = OrderDraft(
      customerId: state.draft.customerId,
      storeLocationId: state.draft.storeLocationId,
      items: state.draft.items,
      payment: state.draft.payment,
    );

    emit(OrderDraftState(updatedDraft));
  }

  void _onStoreSelected(StoreSelected event, Emitter<OrderDraftState> emit) {
    final updatedDraft = state.draft.withStoreLocation(event.storeId);
    emit(OrderDraftState(updatedDraft));
  }

  void _onItemAdded(ItemAdded event, Emitter<OrderDraftState> emit) {
    final updatedDraft = state.draft.withItems([
      ...state.draft.items,
      event.item,
    ]);
    emit(OrderDraftState(updatedDraft));
  }

  void _onItemRemoved(ItemRemoved event, Emitter<OrderDraftState> emit) {
    final updatedItems = [...state.draft.items]..removeAt(event.index);

    final updatedDraft = state.draft.withItems(updatedItems);
    emit(OrderDraftState(updatedDraft));
  }

  void _onPaymentAdded(PaymentAdded event, Emitter<OrderDraftState> emit) {
    final updatedDraft = state.draft.withPayment(event.payment);
    emit(OrderDraftState(updatedDraft));
  }

  void _onOrderDraftReset(
    OrderDraftReset event,
    Emitter<OrderDraftState> emit,
  ) {
    emit(OrderDraftState.initial());
  }
}

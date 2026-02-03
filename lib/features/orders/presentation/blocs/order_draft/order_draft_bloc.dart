import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    on<ItemQuantityIncreased>(_onItemQuantityIncreased);
    on<ItemQuantityDecreased>(_onItemQuantityDecreased);
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
      items: [],
      payments: [],
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
      payments: state.draft.payments,
    );

    emit(OrderDraftState(updatedDraft));
  }

  void _onStoreSelected(StoreSelected event, Emitter<OrderDraftState> emit) {
    final updatedDraft = state.draft.withStoreLocation(event.storeId);
    emit(OrderDraftState(updatedDraft));
  }

  void _onItemAdded(ItemAdded event, Emitter<OrderDraftState> emit) {
    final items = [...state.draft.items];

    final index = items.indexWhere(
      (i) => i.productID == event.item.productID && i.type == event.item.type,
    );

    if (index == -1) {
      items.add(event.item);
    } else {
      final existing = items[index];
      final updated = OrderItem(
        productID: existing.productID,
        productName: existing.productName,
        productCode: existing.productCode,
        type: existing.type,
        quantity: existing.quantity + 1,
        unitPrice: existing.unitPrice,
      );

      items[index] = updated;
    }

    emit(OrderDraftState(state.draft.withItems(items)));
  }

  void _onItemRemoved(ItemRemoved event, Emitter<OrderDraftState> emit) {
    final updatedItems = [...state.draft.items]..removeAt(event.index);

    final updatedDraft = state.draft.withItems(updatedItems);
    emit(OrderDraftState(updatedDraft));
  }

  void _onItemQuantityIncreased(
    ItemQuantityIncreased event,
    Emitter<OrderDraftState> emit,
  ) {
    final updatedItems = state.draft.items.map((item) {
      if (item.productID == event.productId) {
        final updated = OrderItem(
          productID: item.productID,
          productName: item.productName,
          productCode: item.productCode,
          type: item.type,
          quantity: item.quantity + 1,
          unitPrice: item.unitPrice,
        );
        return updated;
      }

      return item;
    }).toList();

    emit(OrderDraftState(state.draft.withItems(updatedItems)));
  }

  void _onItemQuantityDecreased(
    ItemQuantityDecreased event,
    Emitter<OrderDraftState> emit,
  ) {
    final updatedItems = <OrderItem>[];

    for (final item in state.draft.items) {
      if (item.productID == event.productId) {
        final updated = OrderItem(
          productID: item.productID,
          productName: item.productName,
          productCode: item.productCode,
          type: item.type,
          quantity: item.quantity - 1,
          unitPrice: item.unitPrice,
        );

        if (updated.quantity > 0) {
          updatedItems.add(updated);
        }
      } else {
        return updatedItems.add(item);
      }
    }

    emit(OrderDraftState(state.draft.withItems(updatedItems)));
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

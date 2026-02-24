import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/orders/domain/entities/order_item.dart';
import 'package:osm/features/orders/domain/entities/order_item_type.dart';
import 'package:osm/features/orders/domain/entities/payment.dart';
import 'package:osm/features/orders/domain/value_objects/order_draft.dart';
import 'package:osm/features/prescription/domain/entities/prescription.dart';

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
    emit(state.copyWith(draft: state.draft.withCustomer(event.customerId)));
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
  ) async {
    var updatedDraft = state.draft.withPrescription(event.prescription.id!);

    

    final updatedItems = updatedDraft.items.map((item) {
      if (item.type == OrderItemType.lens) {
        return item.copyWith(
          rightEye: event.prescription.rightEye,
          leftEye: event.prescription.leftEye,
          pd: event.prescription.pd,
        );
      }

      if (item.type == OrderItemType.lens) {
        debugPrint("${item.rightEye.toString()} in draft bloc");
        debugPrint(event.prescription.rightEye.toString());
        debugPrint(event.prescription.leftEye.toString());
      }

      return item;
    }).toList();


    emit(
      state.copyWith(
        draft: updatedDraft.withItems(updatedItems),
        selectedPrescription: event.prescription,
      ),
    );
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

    emit(state.copyWith(draft: updatedDraft, clearPrescription: true));
  }

  void _onStoreSelected(StoreSelected event, Emitter<OrderDraftState> emit) {
    emit(state.copyWith(draft: state.draft.withStoreLocation(event.storeId)));
  }

  void _onItemAdded(ItemAdded event, Emitter<OrderDraftState> emit) {
    final items = [...state.draft.items];
    OrderItem newItem = event.item;

    if (newItem.type == OrderItemType.lens &&
        state.selectedPrescription != null) {
      newItem = newItem.copyWith(
        rightEye: state.selectedPrescription!.rightEye,
        leftEye: state.selectedPrescription!.leftEye,
        pd: state.selectedPrescription!.pd,
      );
    }

    final index = items.indexWhere(
      (i) {
        final isSameProduct = i.productID == newItem.productID;

        if (newItem.type == OrderItemType.lens) {
          final isSameMaterial = i.materialType == newItem.materialType;

          if (i.coatings != null && newItem.coatings != null) {
            final isSameCoatings = i.coatings!.length == newItem.coatings!.length && i.coatings!.every((c) => newItem.coatings!.contains(c));

            return isSameProduct && isSameMaterial && isSameCoatings;
          }

          return isSameProduct && isSameMaterial;
        }

        return isSameProduct;
      },
    );

    if (index == -1) {
      items.add(newItem);
    } else {
      final existing = items[index];
      final updated = existing.copyWith(quantity: existing.quantity + 1);

      items[index] = updated;
    }

    emit(state.copyWith(draft: state.draft.withItems(items)));
  }

  void _onItemRemoved(ItemRemoved event, Emitter<OrderDraftState> emit) {
    final updatedItems = [...state.draft.items]..removeAt(event.index);
    emit(state.copyWith(draft: state.draft.withItems(updatedItems)));
  }

  void _onItemQuantityIncreased(
    ItemQuantityIncreased event,
    Emitter<OrderDraftState> emit,
  ) {
    final updatedItems = state.draft.items.map((item) {
      if (item.productID == event.productId) {
        return item.copyWith(quantity: item.quantity + 1);
      }

      return item;
    }).toList();

    emit(state.copyWith(draft: state.draft.withItems(updatedItems)));
  }

  void _onItemQuantityDecreased(
    ItemQuantityDecreased event,
    Emitter<OrderDraftState> emit,
  ) {
    final updatedItems = state.draft.items
        .map((item) {
          if (item.productID == event.productId) {
            return item.copyWith(quantity: item.quantity - 1);
          }
          return item;
        })
        .where((item) => item.quantity > 0)
        .toList();

    emit(state.copyWith(draft: state.draft.withItems(updatedItems)));
  }

  void _onPaymentAdded(PaymentAdded event, Emitter<OrderDraftState> emit) {
    emit(state.copyWith(draft: state.draft.withPayment(event.payment)));
  }

  void _onOrderDraftReset(
    OrderDraftReset event,
    Emitter<OrderDraftState> emit,
  ) {
    emit(OrderDraftState.initial());
  }
}

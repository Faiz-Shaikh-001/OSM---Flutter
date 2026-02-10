part of 'order_draft_bloc.dart';

@immutable
sealed class OrderDraftEvent extends Equatable {
  const OrderDraftEvent();

  @override
  List<Object?> get props => [];
}

class CustomerSelected extends OrderDraftEvent {
  final CustomerId customerId;

  const CustomerSelected(this.customerId);

  @override
  List<Object?> get props => [customerId];
}

class CustomerRemoved extends OrderDraftEvent {}

class PrescriptionSelected extends OrderDraftEvent {
  final PrescriptionId prescriptionId;

  const PrescriptionSelected(this.prescriptionId);

  @override
  List<Object?> get props => [prescriptionId];
}

class PrescriptionCleared extends OrderDraftEvent {}

class StoreSelected extends OrderDraftEvent {
  final StoreLocationId storeId;

  const StoreSelected(this.storeId);

  @override
  List<Object?> get props => [storeId];
}

class ItemAdded extends OrderDraftEvent {
  final OrderItem item;

  const ItemAdded(this.item);

  @override
  List<Object?> get props => [item];
}

class ItemRemoved extends OrderDraftEvent {
  final int index;

  const ItemRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class ItemQuantityIncreased extends OrderDraftEvent {
  final String productId;

  const ItemQuantityIncreased(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ItemQuantityDecreased extends OrderDraftEvent {
  final String productId;

  const ItemQuantityDecreased(this.productId);
  
  @override
  List<Object?> get props => [productId];
}

class PaymentAdded extends OrderDraftEvent {
  final Payment payment;

  const PaymentAdded(this.payment);

  @override
  List<Object?> get props => [payment];
}

class OrderDraftReset extends OrderDraftEvent {}

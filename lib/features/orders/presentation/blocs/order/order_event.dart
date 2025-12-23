part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {
  const OrderEvent();
}

class LoadOrdersEvent extends OrderEvent {
  const LoadOrdersEvent();
}

class StartOrderDraft extends OrderEvent {
  const StartOrderDraft();
}

class SetOrderCustomer extends OrderEvent {
  final Customer customer;
  const SetOrderCustomer(this.customer);
}

class SetOrderItems extends OrderEvent {
  final List<OrderItem> items;
  const SetOrderItems(this.items);
}

class AddDraftPayment extends OrderEvent {
  final Payment payment;
  const AddDraftPayment(this.payment);
}

class SubmitOrderDraft extends OrderEvent {}

class ResetOrderDraft extends OrderEvent {}

class DeleteOrderEvent extends OrderEvent {
  final int orderId;
  const DeleteOrderEvent(this.orderId);
}

class UpdateOrderStatusEvent extends OrderEvent {
  final int orderId;
  final OrderStatus status;
  const UpdateOrderStatusEvent(this.orderId, this.status);
}

class AddPaymentToOrder extends OrderEvent {
  final int orderId;
  final Payment payment;
  const AddPaymentToOrder(this.orderId, this.payment);
}

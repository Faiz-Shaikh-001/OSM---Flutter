part of 'order_bloc.dart';

@immutable
sealed class OrderState {
  const OrderState();
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderLoading extends OrderState {
  const OrderLoading();
}

class OrderLoaded extends OrderState {
  final List<Order> orders;
  const OrderLoaded(this.orders);
}

class OrderDrafting extends OrderState {
  final OrderDraft draft;
  final int currentStep;

  const OrderDrafting({
    required this.draft,
    required this.currentStep,
  });
}

class OrderSubmitting extends OrderState {
  const OrderSubmitting();
}

class OrderCreated extends OrderState {
  final Order order;
  const OrderCreated(this.order);
}

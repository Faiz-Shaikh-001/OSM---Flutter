enum OrderStatus { draft, pendingPayment, completed, cancelled }

extension OrderStatusX on OrderStatus {
  bool get isActive => this == OrderStatus.draft || this == OrderStatus.pendingPayment;
}
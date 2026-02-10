enum OrderStatus { draft, pendingPayment, completed, cancelled }

extension OrderStatusX on OrderStatus {
  bool get isActive =>
      this == OrderStatus.draft || this == OrderStatus.pendingPayment;

  String get label {
    switch (this) {
      case OrderStatus.draft:
        return "Draft";
      case OrderStatus.pendingPayment:
        return "Pending Payment";
      case OrderStatus.completed:
        return "Completed";
      case OrderStatus.cancelled:
        return "Cancelled";
    }
  }
}

enum ActivityType {
  newOrder,
  paymentReceived,
  lowStockAlert,
  stockUpdated,
  newStockAdded,
  newCustomerAdded,
  customerUpdated,
  customerDeleted,
}

class Activity {
  final int? id;
  final ActivityType type;
  final DateTime occurredAt;
  final Map<String, dynamic> metadata;

  const Activity({
    this.id,
    required this.type,
    required this.occurredAt,
    this.metadata = const {},
  });
}

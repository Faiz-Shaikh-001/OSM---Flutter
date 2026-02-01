import 'package:osm/core/value_objects/id.dart';
import 'package:osm/core/value_objects/money.dart';

import 'order_item.dart';
import 'order_enums.dart';
import 'payment.dart';


class Order {
  final OrderId id;
  final DateTime createdAt;
  final OrderStatus status;
  final CustomerId customerId;
  final PrescriptionId? prescriptionId;
  final StoreLocationId storeLocationId;
  final List<OrderItem> items;
  final List<Payment> payments;

  const Order.rehydrate({
    required this.id,
    required this.createdAt,
    required this.status,
    required this.customerId,
    this.prescriptionId,
    required this.storeLocationId,
    required this.items,
    required this.payments,
  });

  factory Order.newOrder({
    required DateTime createdAt,
    required OrderStatus status,
    required CustomerId customerId,
    PrescriptionId? prescriptionId,
    required StoreLocationId storeLocationId,
    required List<OrderItem> items,
    required List<Payment> payments,
  }) {
    return Order.rehydrate(
      id: OrderId.empty(),
      createdAt: createdAt,
      status: status,
      customerId: customerId,
      prescriptionId: prescriptionId,
      storeLocationId: storeLocationId,
      items: items,
      payments: payments,
    );
  }

  Money get totalAmount => items.fold(Money(0), (sum, item) => sum + item.total);

  Money get paidAmount =>
      payments.fold(Money(0), (sum, p) => sum + p.amountPaid);

  Money get pendingAmount => totalAmount - paidAmount;

  bool get isFullyPaid => pendingAmount.isZero;

  bool get canBeCompleted =>
      status != OrderStatus.completed && isFullyPaid;
}

import 'package:equatable/equatable.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/orders/domain/entities/order_enums.dart';
import 'package:osm/features/orders/domain/entities/order_item.dart';
import 'package:osm/features/orders/domain/entities/payment.dart';

class Order extends Equatable {
  final OrderId id;
  final DateTime createdAt;
  final OrderStatus status;
  final CustomerId customerId;
  final PrescriptionId? prescriptionId;
  final StoreLocationId storeLocationId;
  final List<OrderItem> items;
  final List<Payment> payments;

  const Order._({
    required this.id,
    required this.createdAt,
    required this.status,
    required this.customerId,
    this.prescriptionId,
    required this.storeLocationId,
    required this.items,
    required this.payments,
  });

  factory Order.rehydrate({
    required OrderId id,
    required DateTime createdAt,
    required OrderStatus status,
    required CustomerId customerId,
    PrescriptionId? prescriptionId,
    required StoreLocationId storeLocationId,
    required List<OrderItem> items,
    required List<Payment> payments,
  }) {
    return Order._(
      id: id,
      createdAt: createdAt,
      status: status,
      customerId: customerId,
      prescriptionId: prescriptionId,
      storeLocationId: storeLocationId,
      items: items,
      payments: payments,
    );
  }

  factory Order.newOrder({
    required DateTime createdAt,
    required CustomerId customerId,
    PrescriptionId? prescriptionId,
    required StoreLocationId storeLocationId,
    required List<OrderItem> items,
    List<Payment>? initialPayments,
  }) {
    final payments = initialPayments ?? [];
    
    OrderStatus initialStatus = OrderStatus.draft;
    
    final total = items.fold(Money(0), (sum, item) => sum + item.total);
    final paid = payments.fold(Money(0), (sum, p) => sum + p.amountPaid);
    
    if (payments.isNotEmpty) {
      if (paid.value >= total.value) {
        initialStatus = OrderStatus.completed;
      } else {
        initialStatus = OrderStatus.pendingPayment;
      }
    }

    return Order._(
      id: OrderId.empty(), 
      createdAt: createdAt,
      status: initialStatus,
      customerId: customerId,
      prescriptionId: prescriptionId,
      storeLocationId: storeLocationId,
      items: items,
      payments: payments,
    );
  }

  Money get totalAmount => items.fold(Money(0), (sum, item) => sum + item.total);

  Money get paidAmount => payments.fold(Money(0), (sum, p) => sum + p.amountPaid);

  Money get pendingAmount {
    final pending = totalAmount - paidAmount;
    return pending.value < 0 ? Money(0) : pending; // Prevent negative pending
  }

  bool get isFullyPaid => pendingAmount.isZero;

  bool get canBeCompleted => status != OrderStatus.completed && isFullyPaid;

  Order addPayment(Payment payment) {
    final updatedPayments = List<Payment>.from(payments)..add(payment);
    
    final newPaidAmount = updatedPayments.fold(Money(0), (sum, p) => sum + p.amountPaid);
    
    OrderStatus newStatus = status;
    if (newPaidAmount.value >= totalAmount.value) {
       newStatus = OrderStatus.completed; 
    } else {
       newStatus = OrderStatus.pendingPayment;
    }

    return Order._(
      id: id,
      createdAt: createdAt,
      status: newStatus,
      customerId: customerId,
      prescriptionId: prescriptionId,
      storeLocationId: storeLocationId,
      items: items,
      payments: updatedPayments,
    );
  }

  @override
  List<Object?> get props => [
        id, createdAt, status, customerId, prescriptionId, storeLocationId, items, payments
      ];
}
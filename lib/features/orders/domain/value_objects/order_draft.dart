import 'package:osm/core/value_objects/id.dart';
import 'package:osm/core/value_objects/money.dart';
import '../entities/order_item.dart';
import '../entities/payment.dart';

class OrderDraft {
  final CustomerId? customerId;
  final PrescriptionId? prescriptionId;
  final StoreLocationId? storeLocationId;
  final List<OrderItem> items;
  final List<Payment>? payments;

  const OrderDraft({
    this.customerId,
    this.prescriptionId,
    this.storeLocationId,
    this.items = const [],
    this.payments = const [],
  });

  factory OrderDraft.empty() {
    return const OrderDraft();
  }

  // Validation helpers

  bool get isCustomerSelected => customerId != null;
  bool get hasPrescription => prescriptionId != null;
  bool get isStoreSelected => storeLocationId != null;
  bool get hasItems => items.isNotEmpty;

  bool get isComplete => isCustomerSelected && isStoreSelected && hasItems;

  Money get totalAmount =>
      items.fold(Money(0), (sum, item) => sum + item.total);

  // Immutable builders

  OrderDraft withCustomer(CustomerId customerId) {
    return OrderDraft(
      customerId: customerId,
      prescriptionId: prescriptionId,
      storeLocationId: storeLocationId,
      items: items,
      payments: payments,
    );
  }

  OrderDraft withPrescription(PrescriptionId prescriptionId) {
    return OrderDraft(
      customerId: customerId,
      prescriptionId: prescriptionId,
      storeLocationId: storeLocationId,
      items: items,
      payments: payments,
    );
  }

  OrderDraft withStoreLocation(StoreLocationId storeLocationId) {
    return OrderDraft(
      customerId: customerId,
      prescriptionId: prescriptionId,
      storeLocationId: storeLocationId,
      items: items,
      payments: payments,
    );
  }

  OrderDraft withItems(List<OrderItem> items) {
    return OrderDraft(
      customerId: customerId,
      prescriptionId: prescriptionId,
      storeLocationId: storeLocationId,
      items: items,
      payments: payments,
    );
  }

  OrderDraft withPayment(List<Payment> payment) {
    return OrderDraft(
      customerId: customerId,
      prescriptionId: prescriptionId,
      storeLocationId: storeLocationId,
      items: items,
      payments: payment,
    );
  }
}

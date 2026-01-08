import 'package:osm/core/value_objects/id.dart';
import 'package:osm/core/value_objects/money.dart';
import '../entities/order_item.dart';
import '../entities/payment.dart';

class OrderDraft {
  final CustomerId? customerId;
  final PrescriptionId? prescriptionId;
  final StoreLocationId? storeLocationId;
  final List<OrderItem> items;
  final Payment? payment;

  const OrderDraft({
    this.customerId,
    this.prescriptionId,
    this.storeLocationId,
    this.items = const [],
    this.payment,
  });

  factory OrderDraft.empty() {
    return const OrderDraft();
  }

  // Validation helpers

  bool get isCustomerSelected => customerId != null;
  bool get hasPrescription => prescriptionId != null;
  bool get isStoreSelected => storeLocationId != null;
  bool get hasItems => items.isNotEmpty;
  bool get isPaymentDone => payment != null;

  bool get isComplete => isCustomerSelected && isStoreSelected && hasItems;

  // Immutable builders

  OrderDraft withCustomer(CustomerId customerId) {
    return OrderDraft(
      customerId: customerId,
      prescriptionId: prescriptionId,
      storeLocationId: storeLocationId,
      items: items,
      payment: payment,
    );
  }

  OrderDraft withPrescription(PrescriptionId prescriptionId) {
    return OrderDraft(
      customerId: customerId,
      prescriptionId: prescriptionId,
      storeLocationId: storeLocationId,
      items: items,
      payment: payment,
    );
  }

  OrderDraft withStoreLocation(StoreLocationId storeLocationId) {
    return OrderDraft(
      customerId: customerId,
      prescriptionId: prescriptionId,
      storeLocationId: storeLocationId,
      items: items,
      payment: payment,
    );
  }

  OrderDraft withItems(List<OrderItem> items) {
    return OrderDraft(
      customerId: customerId,
      prescriptionId: prescriptionId,
      storeLocationId: storeLocationId,
      items: items,
      payment: payment,
    );
  }

  OrderDraft withPayment(Payment payment) {
    return OrderDraft(
      customerId: customerId,
      prescriptionId: prescriptionId,
      storeLocationId: storeLocationId,
      items: items,
      payment: payment,
    );
  }

  Money get totalAmount =>
      items.fold(Money(0), (sum, item) => sum + item.total);
}

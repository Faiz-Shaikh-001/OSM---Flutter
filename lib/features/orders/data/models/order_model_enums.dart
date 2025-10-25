import 'package:isar/isar.dart';
import 'package:osm/features/orders/data/models/order_model.dart';

@Enumerated(EnumType.name)
enum OrderStatus { pending, completed, cancelled }

extension OrderStatusX on OrderStatus {
  String get label => switch (this) {
    OrderStatus.pending => "Pending",
    OrderStatus.completed => "Completed",
    OrderStatus.cancelled => "Cancelled",
  };
}

extension OrderModelX on OrderModel {
  Future<void> loadAllRelations() async {
    await customer.load();
    await prescription.load();
    await payments.load();
    await items.load();
    await storeLocation.load();

    for (final item in items) {
      await item.frame.load();
      await item.lens.load();
    }
  }
}

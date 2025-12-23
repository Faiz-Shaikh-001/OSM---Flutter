import 'package:isar/isar.dart';
import '../models/order_item/order_item_model.dart';
import '../models/order/order_model.dart';

class OrderItemLocalRepository {
  final Isar isar;
  OrderItemLocalRepository(this.isar);

  Future<int> insert({
    required OrderItemModel item,
    required OrderModel order,
  }) async {
    return isar.writeTxn(() async {
      item.order.value = order;
      final id = await isar.orderItemModels.put(item);

      order.items.add(item);
      await order.items.save();

      return id;
    });
  }

  Future<void> update(OrderItemModel item) {
    return isar.writeTxn(() async {
      await isar.orderItemModels.put(item);
    });
  }

  Future<bool> delete(int id) {
    return isar.writeTxn(() async {
      return await isar.orderItemModels.delete(id);
    });
  }
}

import 'package:isar/isar.dart';
import '../models/order_item/order_item_model.dart';
import '../models/order/order_model.dart';

class OrderItemLocalRepository {
  OrderItemLocalRepository();

  Future<int> insert({
    required OrderItemModel item,
    required OrderModel order,
    required Isar isar,
  }) async {
    return isar.writeTxn(() async {
      item.order.value = order;
      final id = await isar.orderItemModels.put(item);

      order.items.add(item);
      await order.items.save();

      return id;
    });
  }

  Future<void> update(OrderItemModel item, Isar isar) {
    return isar.writeTxn(() async {
      await isar.orderItemModels.put(item);
    });
  }

  Future<bool> delete(int id, Isar isar) {
    return isar.writeTxn(() async {
      return await isar.orderItemModels.delete(id);
    });
  }
}

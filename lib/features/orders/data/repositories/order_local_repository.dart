import 'package:isar/isar.dart';
import 'package:osm/features/customer/data/models/customer_model.dart';
import 'package:osm/features/orders/data/models/order_item/order_item_model.dart';
import 'package:osm/features/orders/data/models/payment/payment_model.dart';
import '../models/order/order_model.dart';

class OrderLocalRepository {

  Future<OrderModel?> getById(int id, Isar isar) async {
    return isar.orderModels.get(id);
  }

  Future<List<OrderModel>> getAll(Isar isar) async {
    return isar.orderModels.where().findAll();
  }

  Stream<List<OrderModel>> watchAll(Isar isar) async* {
    yield* isar.orderModels.where().watch(fireImmediately: true);
  }

  Future<int> insert(OrderModel model, Isar isar) async {
    return isar.writeTxn(() => isar.orderModels.put(model));
  }

  Future<void> save(OrderModel model, Isar isar) async {
    return isar.writeTxn(() => isar.orderModels.put(model));
  }

  Future<List<OrderModel>> getByCustomer(int customerId, Isar isar) async {
    return isar.orderModels
        .filter()
        .customer((c) => c.idEqualTo(customerId))
        .findAll();
  }

  Future<void> delete(int id, Isar isar) async {
    await isar.writeTxn(() async {
      await isar.orderItemModels
          .filter()
          .order((o) => o.idEqualTo(id))
          .deleteAll();

      await isar.paymentModels
          .filter()
          .order((o) => o.idEqualTo(id))
          .deleteAll();

      await isar.orderModels.delete(id);
    });
  }

  Future<List<OrderModel>> searchByCustomerOrOrderId(String query, Isar isar) async {
    final parsedId = int.tryParse(query);
    return isar.orderModels
        .filter()
        .group(
          (q) => q
              .customer((c) => c.firstNameContains(query, caseSensitive: false))
              .or()
              .customer((c) => c.lastNameContains(query, caseSensitive: false))
              .or()
              .idEqualTo(parsedId ?? -1),
        )
        .findAll();
  }
}

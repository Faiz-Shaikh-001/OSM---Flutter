import 'package:isar/isar.dart';
import '../models/payment/payment_model.dart';
import '../models/order/order_model.dart';

class PaymentLocalRepository {
  PaymentLocalRepository();

  Future<int> insert({
    required PaymentModel payment,
    required OrderModel order,
    required Isar isar,
  }) async {
    payment.order.value = order;
    final id = await isar.paymentModels.put(payment);

    order.payments.add(payment);
    await order.payments.save();

    return id;
  }

  Future<void> update(PaymentModel payment, Isar isar) async {
    return isar.writeTxn(() async {
      await isar.paymentModels.put(payment);
    });
  }

  Future<bool> delete(int id, Isar isar) async {
    return isar.writeTxn(() async {
      return await isar.paymentModels.delete(id);
    });
  }
}

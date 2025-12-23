import 'package:osm/core/services/isar_service.dart';
import '../models/payment/payment_model.dart';
import '../models/order/order_model.dart';

class PaymentLocalRepository {
  final IsarService _isarService;
  PaymentLocalRepository(this._isarService);

  Future<int> insert({
    required PaymentModel payment,
    required OrderModel order,
  }) async {
    final isar = await _isarService.db;
    return isar.writeTxn(() async {
      payment.order.value = order;
      final id = await isar.paymentModels.put(payment);

      order.payments.add(payment);
      await order.payments.save();

      return id;
    });
  }

  Future<void> update(PaymentModel payment) async {
    final isar = await _isarService.db;
    return isar.writeTxn(() async {
      await isar.paymentModels.put(payment);
    });
  }

  Future<bool> delete(int id) async {
    final isar = await _isarService.db;
    return isar.writeTxn(() async {
      return await isar.paymentModels.delete(id);
    });
  }
}

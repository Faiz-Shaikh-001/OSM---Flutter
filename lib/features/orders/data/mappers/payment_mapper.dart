import 'package:osm/core/value_objects/money_mapper.dart';
import 'package:osm/features/orders/data/mappers/order_enums_mapper.dart';

import '../../domain/entities/payment.dart';
import '../models/payment/payment_model.dart';

class PaymentMapper {
  static Payment toEntity(PaymentModel model) {
    return Payment(
      paymentDate: model.paymentDate,
      amountPaid: MoneyMapper.fromPaise(model.amountPaid),
      method: OrderEnumsMapper.toPaymentMethod(model.paymentMethod),
      status: OrderEnumsMapper.toPaymentStatus(model.status),
    );
  }

  static PaymentModel toModel(Payment payment) {
    return PaymentModel(
      paymentDate: payment.paymentDate,
      amountPaid: MoneyMapper.toPaise(payment.amountPaid),
      status: OrderEnumsMapper.toPaymentStatusModel(payment.status), paymentMethod: OrderEnumsMapper.toPaymentMethodModel(payment.method),
    );
  }
}

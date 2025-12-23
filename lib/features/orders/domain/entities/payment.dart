import 'package:osm/features/orders/domain/entities/payment_enums.dart';
import 'package:osm/core/value_objects/money.dart';

class Payment {
  final DateTime paymentDate;
  final Money amountPaid;
  final PaymentMethod method;
  final PaymentStatus status;

  const Payment({
    required this.paymentDate,
    required this.amountPaid,
    required this.method,
    required this.status,
  });
}

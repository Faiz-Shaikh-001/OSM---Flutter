import 'package:equatable/equatable.dart';
import 'package:osm/features/orders/domain/entities/payment_enums.dart';
import 'package:osm/core/value_objects/money.dart';

class Payment extends Equatable {
  final String? id;
  final DateTime paymentDate;
  final Money amountPaid;
  final PaymentMethod method;
  final PaymentStatus status;
  final String? transactionId;

  const Payment({
    this.id,
    required this.paymentDate,
    required this.amountPaid,
    required this.method,
    required this.status,
    this.transactionId,
  });

  @override
  List<Object?> get props => [id, paymentDate, amountPaid, method, status, transactionId];
}

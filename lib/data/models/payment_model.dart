import 'package:isar/isar.dart';
import 'order_model.dart';

part 'payment_model.g.dart';

@Collection()
class PaymentModel {
  Id id = Isar.autoIncrement;

  final DateTime paymentDate;
  final double amountPaid;
  final String paymentMethod;
  final String? transactionId;
  final String status;

  // --- RelationShips ---
  final order = IsarLink<OrderModel>();

  PaymentModel({
    required this.paymentDate,
    required this.amountPaid,
    required this.paymentMethod,
    this.transactionId,
    required this.status,
  });

  PaymentModel copyWith({
    Id? id,
    DateTime? paymentDate,
    double? amountPaid,
    String? paymentMethod,
    String? transactionId,
    String? status,
  }) {
    return PaymentModel(
      paymentDate: paymentDate ?? this.paymentDate,
      amountPaid: amountPaid ?? this.amountPaid,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionId: transactionId ?? this.transactionId,
      status: status ?? this.status,
    )..id = id ?? this.id;
  }
}

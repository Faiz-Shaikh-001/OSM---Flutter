import 'package:isar/isar.dart';
import 'package:osm/features/orders/data/enums/payment_method_model.dart';
import 'package:osm/features/orders/data/enums/payment_status_model.dart';
import '../order/order_model.dart';

part 'payment_model.g.dart';

@Collection()
class PaymentModel {
  Id id = Isar.autoIncrement;

  final DateTime paymentDate;
  final int amountPaid;
  
  @Enumerated(EnumType.name)
  final PaymentStatusModel status;

  @Enumerated(EnumType.name)
  final PaymentMethodModel paymentMethod;

  final String? transactionId;

  // --- Relations ---
  final IsarLink<OrderModel> order; 

  PaymentModel({
    required this.paymentDate,
    required this.amountPaid,
    required this.paymentMethod,
    this.transactionId,
    required this.status,
    IsarLink<OrderModel>? order,
  }) : order = order ?? IsarLink<OrderModel>();
}

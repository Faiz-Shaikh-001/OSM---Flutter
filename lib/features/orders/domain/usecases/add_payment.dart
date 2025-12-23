import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import '../entities/payment.dart';
import '../failures/order_failure.dart';
import '../repositories/order_repository.dart';

class AddPayment {
  final OrderRepository repository;

  AddPayment(this.repository);

  Future<Either<OrderFailure, void>> call(
    OrderId orderId,
    Payment payment,
  ) {
    return repository.addPayment(orderId, payment);
  }
}

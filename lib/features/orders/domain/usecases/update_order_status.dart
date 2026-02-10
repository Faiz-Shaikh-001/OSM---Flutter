import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import '../entities/order_enums.dart';
import '../failures/order_failure.dart';
import '../repositories/order_repository.dart';

class UpdateOrderStatus {
  final OrderRepository repository;

  UpdateOrderStatus(this.repository);

  Future<Either<OrderFailure, void>> call(
    OrderId orderId,
    OrderStatus status,
  ) {
    return repository.updateStatus(orderId, status);
  }
}

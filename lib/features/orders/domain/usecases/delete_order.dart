import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import '../failures/order_failure.dart';
import '../repositories/order_repository.dart';

class DeleteOrder {
  final OrderRepository repository;

  DeleteOrder(this.repository);

  Future<Either<OrderFailure, Order>> call(OrderId orderId) {
    return repository.delete(orderId);
  }
}

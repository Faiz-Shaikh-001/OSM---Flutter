import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/orders/domain/failures/order_failure.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class CreateOrder {
  final OrderRepository repository;

  CreateOrder(this.repository);

  Future<Either<OrderFailure, OrderId>> call(Order order) {
    return repository.create(order);
  }
}

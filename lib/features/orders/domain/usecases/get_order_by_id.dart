import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import '../entities/order.dart';
import '../failures/order_failure.dart';
import '../repositories/order_repository.dart';

class GetOrderById {
  final OrderRepository repository;

  GetOrderById(this.repository);

  Future<Either<OrderFailure, Order>> call(OrderId id) {
    return repository.getById(id);
  }
}

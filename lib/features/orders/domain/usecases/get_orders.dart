import 'package:osm/core/either.dart';
import 'package:osm/features/orders/domain/failures/order_failure.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrders {
  final OrderRepository repository;

  GetOrders(this.repository);

  Future<Either<OrderFailure, List<Order>>> call() {
    return repository.getAll();
  }
}

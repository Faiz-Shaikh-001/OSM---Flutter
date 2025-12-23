import 'package:osm/core/either.dart';
import '../entities/order.dart';
import '../failures/order_failure.dart';
import '../repositories/order_repository.dart';

class WatchOrders {
  final OrderRepository repository;

  WatchOrders(this.repository);

  Stream<Either<OrderFailure, List<Order>>> call() {
    return repository.watchAll();
  }
}

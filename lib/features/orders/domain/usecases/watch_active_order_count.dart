import 'package:osm/features/orders/domain/repositories/order_repository.dart';

class WatchActiveOrderCount {
  final OrderRepository repository;

  WatchActiveOrderCount(this.repository);

  Stream<int> call() {
    return repository.watchActiveOrderCount();
  }
}

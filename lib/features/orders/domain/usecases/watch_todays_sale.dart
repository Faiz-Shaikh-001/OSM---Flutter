import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/orders/domain/repositories/order_repository.dart';

class WatchTodaysSale {
  final OrderRepository repository;

  WatchTodaysSale(this.repository);

  Stream<Money> call() {
    return repository.watchTodaysSale();
  }
}

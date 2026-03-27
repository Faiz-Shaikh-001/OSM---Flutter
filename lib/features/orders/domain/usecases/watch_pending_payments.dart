import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/orders/domain/repositories/order_repository.dart';

class WatchPendingPayments {
  final OrderRepository repository;

  WatchPendingPayments(this.repository);

  Stream<Money> call() {
    return repository.watchPendingPayments();
  }
}

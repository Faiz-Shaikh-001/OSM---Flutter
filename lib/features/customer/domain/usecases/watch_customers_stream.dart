import 'package:osm/core/either.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/domain/failures/customer_failure.dart';
import 'package:osm/features/customer/domain/repositories/customer_repository.dart';

class WatchCustomersStream {
  final CustomerRepository repository;

  WatchCustomersStream(this.repository);

  Stream<Either<CustomerFailure, List<Customer>>> call() {
    return repository.watchAll();
  }
}

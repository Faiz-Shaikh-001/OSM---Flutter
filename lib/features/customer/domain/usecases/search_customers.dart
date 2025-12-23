import 'package:osm/core/either.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/domain/failures/customer_failure.dart';
import 'package:osm/features/customer/domain/repositories/customer_repository.dart';

class SearchCustomers {
  final CustomerRepository repository;

  SearchCustomers(this.repository);

  Future<Either<CustomerFailure, List<Customer>>> call(String query) {
    return repository.search(query);
  }
}

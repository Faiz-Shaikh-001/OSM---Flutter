import 'package:osm/core/either.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/domain/failures/customer_failure.dart';
import 'package:osm/features/customer/domain/repositories/customer_repository.dart';

class UpdateCustomer {
  final CustomerRepository repository;

  UpdateCustomer(this.repository);

  Future<Either<CustomerFailure, Customer>> call(Customer customer) {
    return repository.update(customer);
  }
}

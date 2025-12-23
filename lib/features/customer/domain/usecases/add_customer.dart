import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/domain/failures/customer_failure.dart';
import 'package:osm/features/customer/domain/repositories/customer_repository.dart';

class AddCustomer {
  final CustomerRepository repository;
  AddCustomer(this.repository);

  Future<Either<CustomerFailure, CustomerId>> call(Customer customer) {
    return repository.add(customer);
  }
}
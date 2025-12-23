import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/domain/failures/customer_failure.dart';
import 'package:osm/features/customer/domain/repositories/customer_repository.dart';

class GetCustomerById {
  final CustomerRepository repository;

  GetCustomerById(this.repository);

  Future<Either<CustomerFailure, Customer>> call(CustomerId id) {
    return repository.getById(id);
  }
}

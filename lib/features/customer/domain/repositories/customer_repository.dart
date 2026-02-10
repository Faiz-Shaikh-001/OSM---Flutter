import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/domain/failures/customer_failure.dart';
import 'package:osm/features/customer/domain/success/customer_success.dart';

abstract class CustomerRepository {
  // Create
  Future<Either<CustomerFailure, CustomerId>> add(Customer customer);

  // Update
  Future<Either<CustomerFailure, Customer>> update(Customer customer);

  // Delete
  Future<Either<CustomerFailure, CustomerSuccess>> delete(CustomerId id);

  // Read
  Future<Either<CustomerFailure, List<Customer>>> getAll();

  Future<Either<CustomerFailure, Customer>> getById(CustomerId id);

  Stream<Either<CustomerFailure, List<Customer>>> watchAll();

  // Search
  Future<Either<CustomerFailure, List<Customer>>> search(String query);
}

import 'package:osm/features/customer/domain/entities/customer.dart';

abstract class CustomerSearchSource {
  Future<List<Customer>> search(String query);
}
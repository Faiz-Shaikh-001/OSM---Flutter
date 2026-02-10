import 'package:osm/core/value_objects/id.dart';

abstract class CustomerSuccess {
  final String message;
  const CustomerSuccess(this.message);
}

class CustomerDeletedSuccess extends CustomerSuccess {
  const CustomerDeletedSuccess() : super('Successfully deleted customer.');
}

class CustomerCreatedSuccess extends CustomerSuccess {
  final CustomerId customerId;
  const CustomerCreatedSuccess(this.customerId)
    : super('Successfully added customer with customerId: $customerId');
}

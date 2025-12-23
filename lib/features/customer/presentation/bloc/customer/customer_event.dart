part of 'customer_bloc.dart';

@immutable
sealed class CustomerEvent {
  const CustomerEvent();
}

// Load all customers
class LoadCustomers extends CustomerEvent {
  const LoadCustomers();
}

// Live updates
class WatchCustomers extends CustomerEvent {
  const WatchCustomers();
}

// Add
class AddCustomerEvent extends CustomerEvent {
  final Customer customer;
  const AddCustomerEvent(this.customer);
}

// Update
class UpdateCustomerEvent extends CustomerEvent {
  final Customer customer;
  const UpdateCustomerEvent(this.customer);
}

class _CustomersUpdated extends CustomerEvent {
  final Either<CustomerFailure, List<Customer>> result;

  const _CustomersUpdated(this.result);
}


// Delete
class DeleteCustomerEvent extends CustomerEvent {
  final Customer customer;
  const DeleteCustomerEvent(this.customer);
}

class UndoDeleteCustomerEvent extends CustomerEvent {
  const UndoDeleteCustomerEvent();
}

// Search
class SearchCustomersEvent extends CustomerEvent {
  final String query;
  const SearchCustomersEvent(this.query);
}

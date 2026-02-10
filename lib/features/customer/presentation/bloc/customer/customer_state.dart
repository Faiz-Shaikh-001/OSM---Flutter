part of 'customer_bloc.dart';

@immutable
sealed class CustomerState {
  const CustomerState();
}

final class CustomerInitial extends CustomerState {
  const CustomerInitial();
}

class CustomerLoading extends CustomerState {
  const CustomerLoading();
}

class CustomerLoaded extends CustomerState {
  final List<Customer> customers;
  const CustomerLoaded(this.customers);
}

class CustomerActionSuccess extends CustomerState {
  final String message;
  const CustomerActionSuccess(this.message);
}

class CustomerDeleted extends CustomerState {
  final Customer customer;
  const CustomerDeleted(this.customer);
}

class CustomerError extends CustomerState {
  final String message;
  const CustomerError(this.message);
}

class CustomerUpdated extends CustomerState {
  final Customer customer;
  const CustomerUpdated(this.customer);
}

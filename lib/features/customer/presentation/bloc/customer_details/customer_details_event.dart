part of 'customer_details_bloc.dart';

@immutable
sealed class CustomerDetailsEvent {
  const CustomerDetailsEvent();
}

class LoadCustomerDetails extends CustomerDetailsEvent {
  final CustomerId customerId;
  const LoadCustomerDetails(this.customerId);
}

class DeleteCustomerRequested extends CustomerDetailsEvent {
  const DeleteCustomerRequested();
}

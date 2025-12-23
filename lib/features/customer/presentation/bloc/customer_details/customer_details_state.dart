part of 'customer_details_bloc.dart';

@immutable
sealed class CustomerDetailsState {
  const CustomerDetailsState();
}

final class CustomerDetailsInitial extends CustomerDetailsState {
  const CustomerDetailsInitial();
}

class CustomerDetailsLoading extends CustomerDetailsState {
  const CustomerDetailsLoading();
}

class CustomerDetailsLoaded extends CustomerDetailsState {
  final CustomerDetails details;
  const CustomerDetailsLoaded(this.details);
}

class CustomerDetailsDeleted extends CustomerDetailsState {
  const CustomerDetailsDeleted();
}

class CustomerDetailsError extends CustomerDetailsState {
  final String message;
  const CustomerDetailsError(this.message);
}

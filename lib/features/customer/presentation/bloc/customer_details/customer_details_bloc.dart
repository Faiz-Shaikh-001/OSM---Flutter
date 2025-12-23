import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/domain/dto/customer_details.dart';
import 'package:osm/features/customer/domain/usecases/delete_customer.dart';
import 'package:osm/features/customer/domain/usecases/get_customer_details.dart';

part 'customer_details_event.dart';
part 'customer_details_state.dart';

class CustomerDetailsBloc
    extends Bloc<CustomerDetailsEvent, CustomerDetailsState> {
  final GetCustomerDetails getCustomerDetails;
  final DeleteCustomer deleteCustomer;

  CustomerDetailsBloc({
    required this.getCustomerDetails,
    required this.deleteCustomer,
  }) : super(CustomerDetailsInitial()) {
    on<LoadCustomerDetails>(_onLoadDetails);
    on<DeleteCustomerRequested>(_onDeleteCustomer);
  }

  Future<void> _onLoadDetails(
    LoadCustomerDetails event,
    Emitter<CustomerDetailsState> emit,
  ) async {
    emit(const CustomerDetailsLoading());

    final result = await getCustomerDetails(event.customerId);

    result.fold(
      (failure) => emit(CustomerDetailsError(failure.message)),
      (details) => emit(CustomerDetailsLoaded(details)),
    );
  }

  Future<void> _onDeleteCustomer(
    DeleteCustomerRequested event,
    Emitter<CustomerDetailsState> emit,
  ) async {
    final currentState = state;

    if (currentState is! CustomerDetailsLoaded) return;

    final result = await deleteCustomer(CustomerId(currentState.details.customer.id!));

    result.fold(
      (failure) => emit(CustomerDetailsError(failure.message)),
      (_) => emit(const CustomerDetailsDeleted()),
    );
  }
}

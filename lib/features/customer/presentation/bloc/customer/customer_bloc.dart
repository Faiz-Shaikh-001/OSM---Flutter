import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/domain/failures/customer_failure.dart';
import 'package:osm/features/customer/domain/usecases/add_customer.dart';
import 'package:osm/features/customer/domain/usecases/delete_customer.dart';
import 'package:osm/features/customer/domain/usecases/get_customers.dart';
import 'package:osm/features/customer/domain/usecases/search_customers.dart';
import 'package:osm/features/customer/domain/usecases/update_customer.dart';
import 'package:osm/features/customer/domain/usecases/watch_customers_stream.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final AddCustomer addCustomer;
  final UpdateCustomer updateCustomer;
  final DeleteCustomer deleteCustomer;
  final GetCustomers getCustomers;
  final SearchCustomers searchCustomers;
  final WatchCustomersStream watchCustomersStream;

  StreamSubscription? _watchSubscription;

  Customer? _lastDeletedCustomer;

  CustomerBloc({
    required this.addCustomer,
    required this.updateCustomer,
    required this.deleteCustomer,
    required this.getCustomers,
    required this.searchCustomers,
    required this.watchCustomersStream,
  }) : super(CustomerInitial()) {
    on<LoadCustomers>(_onLoadCustomers);
    on<WatchCustomers>(_onWatchCustomers);
    on<_CustomersUpdated>(_onCustomersUpdated);
    on<AddCustomerEvent>(_onAddCustomer);
    on<UpdateCustomerEvent>(_onUpdateCustomer);
    on<DeleteCustomerEvent>(_onDeleteCustomer);
    on<UndoDeleteCustomerEvent>(_onUndoDeleteCustomer);
    on<SearchCustomersEvent>(_onSearchCustomers);
  }

  Future<void> _onLoadCustomers(
    LoadCustomers event,
    Emitter<CustomerState> emit,
  ) async {
    emit(const CustomerLoading());
    final result = await getCustomers();

    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (customers) => emit(CustomerLoaded(customers)),
    );
  }

  Future<void> _onWatchCustomers(
    WatchCustomers event,
    Emitter<CustomerState> emit,
  ) async {
    await _watchSubscription?.cancel();

    emit(const CustomerLoading());

    _watchSubscription = watchCustomersStream().listen((result) {
      add(_CustomersUpdated(result));
    });
  }

  void _onCustomersUpdated(
    _CustomersUpdated event,
    Emitter<CustomerState> emit,
  ) {
    event.result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (customers) => emit(CustomerLoaded(customers)),
    );
  }

  Future<void> _onAddCustomer(
    AddCustomerEvent event,
    Emitter<CustomerState> emit,
  ) async {
    emit(const CustomerLoading());

    final result = await addCustomer(event.customer);

    result.fold((failure) => emit(CustomerError(failure.message)), (_) {
      emit(const CustomerActionSuccess('Customer added successfully'));
      add(const WatchCustomers());
    });
  }

  Future<void> _onUpdateCustomer(
    UpdateCustomerEvent event,
    Emitter<CustomerState> emit,
  ) async {
    emit(const CustomerLoading());
    final result = await updateCustomer(event.customer);

    result.fold((failure) => emit(CustomerError(failure.message)), (
      updatedCustomer,
    ) {
      emit(CustomerUpdated(updatedCustomer));
      emit(const CustomerActionSuccess('Customer updated successfully'));
      add(const WatchCustomers());
    });
  }

  Future<void> _onDeleteCustomer(
    DeleteCustomerEvent event,
    Emitter<CustomerState> emit,
  ) async {
    final customerToDelete = event.customer;
    final result = await deleteCustomer(CustomerId(event.customer.id!));

    result.fold((failure) => emit(CustomerError(failure.message)), (
      deletedCustomer,
    ) {
      _lastDeletedCustomer = customerToDelete;
      emit(CustomerDeleted(customerToDelete));
      add(const WatchCustomers());
    });
  }

  Future<void> _onUndoDeleteCustomer(
    UndoDeleteCustomerEvent event,
    Emitter<CustomerState> emit,
  ) async {
    if (_lastDeletedCustomer == null) return;

    final customer = _lastDeletedCustomer!;
    _lastDeletedCustomer = null;

    final result = await addCustomer(customer);

    result.fold((failure) => emit(CustomerError(failure.message)), (_) {
      emit(const CustomerActionSuccess('Customer restored'));
      add(const WatchCustomers());
    });
  }

  Future<void> _onSearchCustomers(
    SearchCustomersEvent event,
    Emitter<CustomerState> emit,
  ) async {
    emit(const CustomerLoading());

    final result = await searchCustomers(event.query);

    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (customers) => emit(CustomerLoaded(customers)),
    );
  }

  @override
  Future<void> close() {
    _watchSubscription?.cancel();
    return super.close();
  }
}

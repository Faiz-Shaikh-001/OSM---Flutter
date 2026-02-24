import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:osm/features/orders/domain/entities/payment.dart';
import 'package:osm/features/orders/domain/failures/order_failure.dart';
import 'package:osm/features/orders/domain/usecases/add_payment.dart';
import 'package:osm/features/orders/domain/usecases/create_order_from_draft.dart';
import 'package:osm/features/orders/domain/value_objects/order_draft.dart';

part 'order_submission_event.dart';
part 'order_submission_state.dart';

class OrderSubmissionBloc
    extends Bloc<OrderSubmissionEvent, OrderSubmissionState> {
  final CreateOrderFromDraft createOrderFromDraft;
  final AddPayment addPayment;

  OrderSubmissionBloc({
    required this.createOrderFromDraft,
    required this.addPayment,
  }) : super(OrderSubmissionInitial()) {
    on<SubmitOrderDraft>(_onSubmit);
    on<AddOrderPayment>(_onAddOrderPayment);
    on<ResetOrderSubmission>(_onReset);
  }

  Future<void> _onSubmit(
    SubmitOrderDraft event,
    Emitter<OrderSubmissionState> emit,
  ) async {
    emit(OrderSubmissionLoading());
    debugPrint("In order submission bloc");
    final result = await createOrderFromDraft(event.draft);

    result.fold((failure) {
      emit(OrderSubmissionFailure(failure));
      debugPrint(failure.message);
    }, (order) => emit(OrderSubmissionSuccess(order)));
  }

  Future<void> _onReset(
    ResetOrderSubmission event,
    Emitter<OrderSubmissionState> emit,
  ) async {
    emit(OrderSubmissionInitial());
  }

  Future<void> _onAddOrderPayment(
    AddOrderPayment event,
    Emitter<OrderSubmissionState> emit,
  ) async {
    emit(OrderSubmissionLoading());

    final result = await addPayment(event.order.id, event.payment);

    result.fold(
      (failure) => emit(OrderSubmissionFailure(failure)),
      (updatedOrder) => emit(OrderSubmissionSuccess(updatedOrder)),
    );
  }
}

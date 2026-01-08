import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:osm/features/orders/domain/failures/order_failure.dart';
import 'package:osm/features/orders/domain/usecases/create_order_from_draft.dart';
import 'package:osm/features/orders/domain/value_objects/order_draft.dart';

part 'order_submission_event.dart';
part 'order_submission_state.dart';

class OrderSubmissionBloc
    extends Bloc<OrderSubmissionEvent, OrderSubmissionState> {
  final CreateOrderFromDraft createOrderFromDraft;

  OrderSubmissionBloc({required this.createOrderFromDraft})
    : super(OrderSubmissionInitial()) {
    on<SubmitOrderDraft>(_onSubmit);
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
}

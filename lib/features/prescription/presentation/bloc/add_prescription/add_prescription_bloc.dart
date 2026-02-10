import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/prescription/domain/entities/prescription.dart';
import 'package:osm/features/prescription/domain/usecases/add_prescription.dart';

part 'add_prescription_event.dart';
part 'add_prescription_state.dart';

class AddPrescriptionBloc
    extends Bloc<AddPrescriptionEvent, AddPrescriptionState> {
  final AddPrescription addPrescription;
  AddPrescriptionBloc({required this.addPrescription})
    : super(AddPrescriptionInitial()) {
    on<SubmitPrescription>(_onSubmit);
  }

  Future<void> _onSubmit(
    SubmitPrescription event,
    Emitter<AddPrescriptionState> emit,
  ) async {
    emit(AddPrescriptionSubmitting());

    final result = await addPrescription(event.prescription, event.customerId);

    result.fold(
      (failure) => emit(AddPrescriptionFailure(failure.message)),
      (_) => emit(AddPrescriptionSuccess(event.prescription)),
    );
  }
}

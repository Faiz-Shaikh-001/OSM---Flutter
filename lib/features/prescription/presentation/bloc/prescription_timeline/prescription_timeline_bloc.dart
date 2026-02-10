import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/prescription/domain/usecases/get_prescription_history.dart';
import 'package:osm/features/prescription/presentation/dto/prescription_with_doctor.dart';

part 'prescription_timeline_event.dart';
part 'prescription_timeline_state.dart';

class PrescriptionTimelineBloc
    extends Bloc<PrescriptionTimelineEvent, PrescriptionTimelineState> {
  final GetPrescriptionHistory getPrescriptionHistory;
  PrescriptionTimelineBloc({required this.getPrescriptionHistory})
    : super(PrescriptionTimelineInitial()) {
    on<LoadPrescriptionTimeline>(_onLoadTimeline);
  }

  Future<void> _onLoadTimeline(
    LoadPrescriptionTimeline event,
    Emitter<PrescriptionTimelineState> emit,
  ) async {
    emit(PrescriptionTimelineLoading());
    final result = await getPrescriptionHistory(event.customerId);

    result.fold(
      (failure) => emit(PrescriptionTimelineError(failure.message)),
      (prescriptions) => emit(PrescriptionTimelineLoaded(prescriptions)),
    );
  }
}

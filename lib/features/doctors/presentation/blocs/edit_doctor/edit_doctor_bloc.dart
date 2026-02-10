import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/doctors/domain/usecases/deactivate_doctor.dart';
import 'package:osm/features/doctors/domain/usecases/update_doctor.dart';

part 'edit_doctor_event.dart';
part 'edit_doctor_state.dart';

class EditDoctorBloc extends Bloc<EditDoctorEvent, EditDoctorState> {
  final UpdateDoctor updateDoctor;
  final DeactivateDoctor deactivateDoctor;

  EditDoctorBloc({required this.updateDoctor, required this.deactivateDoctor})
      : super(EditDoctorInitial()) {
    on<UpdateDoctorEvent>(_onUpdateDoctor);
    on<DeactivateDoctorEvent>(_onDeactivateDoctor);
  }

  Future<void> _onUpdateDoctor(
    UpdateDoctorEvent event,
    Emitter<EditDoctorState> emit,
  ) async {
    emit(EditDoctorSubmitting());

    final result = await updateDoctor(event.doctor);

    result.fold(
      (failure) => emit(EditDoctorFailure(failure.message)),
      (_) => emit(EditDoctorSuccess()),
    );
  }

  Future<void> _onDeactivateDoctor(
    DeactivateDoctorEvent event,
    Emitter<EditDoctorState> emit,
  ) async {
    emit(EditDoctorSubmitting());

    final result = await deactivateDoctor(event.doctorId);

    result.fold(
      (failure) => emit(EditDoctorFailure(failure.message)),
      (_) => emit(EditDoctorDeactivated()),
    );
  }
}

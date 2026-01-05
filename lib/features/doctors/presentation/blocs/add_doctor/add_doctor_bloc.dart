import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/doctors/domain/usecases/add_doctor.dart';

part 'add_doctor_event.dart';
part 'add_doctor_state.dart';

class AddDoctorBloc extends Bloc<AddDoctorEvent, AddDoctorState> {
  final AddDoctor addDoctor;

  AddDoctorBloc({required this.addDoctor})
      : super(AddDoctorInitial()) {
    on<SubmitDoctor>(_onSubmitDoctor);
  }

  Future<void> _onSubmitDoctor(
    SubmitDoctor event,
    Emitter<AddDoctorState> emit,
  ) async {
    emit(AddDoctorSubmitting());

    final result = await addDoctor(event.doctor);

    result.fold(
      (failure) => emit(AddDoctorFailure(failure.message)),
      (doctorId) => emit(AddDoctorSuccess(doctorId)),
    );
  }
}

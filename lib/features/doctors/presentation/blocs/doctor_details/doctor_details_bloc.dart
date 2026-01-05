import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/doctors/domain/usecases/get_doctor_by_id.dart';

part 'doctor_details_event.dart';
part 'doctor_details_state.dart';

class DoctorDetailsBloc
    extends Bloc<DoctorDetailsEvent, DoctorDetailsState> {
  final GetDoctorById getDoctorById;

  DoctorDetailsBloc({required this.getDoctorById})
      : super(DoctorDetailsInitial()) {
    on<LoadDoctorDetails>(_onLoadDoctor);
  }

  Future<void> _onLoadDoctor(
    LoadDoctorDetails event,
    Emitter<DoctorDetailsState> emit,
  ) async {
    emit(DoctorDetailsLoading());

    final result = await getDoctorById(event.doctorId);

    result.fold(
      (failure) => emit(DoctorDetailsError(failure.message)),
      (doctor) {
        if (doctor == null) {
          emit(DoctorDetailsError('Doctor not found'));
        } else {
          emit(DoctorDetailsLoaded(doctor));
        }
      },
    );
  }
}

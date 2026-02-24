import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/doctors/domain/usecases/get_all_doctors.dart';
import 'package:osm/features/doctors/domain/usecases/get_doctors_by_store_location.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final GetAllDoctors getAllDoctor;
  final GetDoctorsByStoreLocation getDoctorsByStoreLocation;
  DoctorBloc({
    required this.getAllDoctor,
    required this.getDoctorsByStoreLocation,
  }) : super(DoctorInitial()) {
    on<LoadDoctors>(_onLoadDoctors);
    on<LoadDoctorsByStore>(_onLoadDoctorsByStore);
  }

  Future<void> _onLoadDoctors(
    LoadDoctors event,
    Emitter<DoctorState> emit,
  ) async {
    emit(DoctorLoading());

    final result = await getAllDoctor();

    result.fold(
      (failure) => emit(DoctorError(failure.message)),
      (doctors) =>
          doctors.isEmpty ? emit(DoctorEmpty()) : emit(DoctorLoaded(doctors)),
    );
  }

  Future<void> _onLoadDoctorsByStore(
    LoadDoctorsByStore event,
    Emitter<DoctorState> emit,
  ) async {
    emit(DoctorLoading());

    final result = await getDoctorsByStoreLocation(event.storeLocationId);

    result.fold(
      (failure) => emit(DoctorError(failure.message)),
      (doctors) =>
          doctors.isEmpty ? emit(DoctorEmpty()) : emit(DoctorLoaded(doctors)),
    );
  }
}

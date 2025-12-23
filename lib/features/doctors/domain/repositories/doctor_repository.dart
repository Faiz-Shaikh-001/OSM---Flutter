import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/doctors/domain/success/doctor_success.dart';
import '../entities/doctor.dart';
import '../failures/doctor_failure.dart';

abstract class DoctorRepository {
  Future<Either<DoctorFailure, DoctorId>> add(
    Doctor doctor,
  );

  Future<Either<DoctorFailure, Doctor>> getById(
    DoctorId id,
  );

  Future<Either<DoctorFailure, List<Doctor>>> getByStoreLocation(
    StoreLocationId storeLocationId,
  );

  Future<Either<DoctorFailure, List<Doctor>>> getAll();

  Future<Either<DoctorFailure, DoctorSuccess>> update(
    Doctor doctor,
  );

  Future<Either<DoctorFailure, DoctorSuccess>> deactivate(
    DoctorId id,
  );
}

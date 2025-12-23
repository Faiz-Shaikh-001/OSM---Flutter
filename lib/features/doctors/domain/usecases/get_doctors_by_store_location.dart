import 'package:osm/core/either.dart';
import '../entities/doctor.dart';
import '../failures/doctor_failure.dart';
import '../repositories/doctor_repository.dart';
import 'package:osm/core/value_objects/id.dart';

class GetDoctorsByStoreLocation {
  final DoctorRepository repository;

  GetDoctorsByStoreLocation(this.repository);

  Future<Either<DoctorFailure, List<Doctor>>> call(
    StoreLocationId storeLocationId,
  ) {
    return repository.getByStoreLocation(storeLocationId);
  }
}

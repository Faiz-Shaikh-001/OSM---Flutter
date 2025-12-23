import 'package:osm/core/either.dart';
import '../entities/doctor.dart';
import '../failures/doctor_failure.dart';
import '../repositories/doctor_repository.dart';
import 'package:osm/core/value_objects/id.dart';

class GetDoctorById {
  final DoctorRepository repository;

  GetDoctorById(this.repository);

  Future<Either<DoctorFailure, Doctor>> call(
    DoctorId id,
  ) {
    return repository.getById(id);
  }
}

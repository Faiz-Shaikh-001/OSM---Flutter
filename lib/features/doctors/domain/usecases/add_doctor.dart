import 'package:osm/core/either.dart';
import '../entities/doctor.dart';
import '../failures/doctor_failure.dart';
import '../repositories/doctor_repository.dart';
import 'package:osm/core/value_objects/id.dart';

class AddDoctor {
  final DoctorRepository repository;

  AddDoctor(this.repository);

  Future<Either<DoctorFailure, DoctorId>> call(
    Doctor doctor,
  ) {
    return repository.add(doctor);
  }
}

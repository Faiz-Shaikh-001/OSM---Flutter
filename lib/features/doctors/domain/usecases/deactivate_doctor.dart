import 'package:osm/core/either.dart';
import 'package:osm/features/doctors/domain/success/doctor_success.dart';
import '../failures/doctor_failure.dart';
import '../repositories/doctor_repository.dart';
import 'package:osm/core/value_objects/id.dart';

class DeactivateDoctor {
  final DoctorRepository repository;

  DeactivateDoctor(this.repository);

  Future<Either<DoctorFailure, DoctorSuccess>> call(
    DoctorId id,
  ) {
    return repository.deactivate(id);
  }
}

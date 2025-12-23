import 'package:osm/core/either.dart';
import 'package:osm/features/doctors/domain/success/doctor_success.dart';
import '../entities/doctor.dart';
import '../failures/doctor_failure.dart';
import '../repositories/doctor_repository.dart';

class UpdateDoctor {
  final DoctorRepository repository;

  UpdateDoctor(this.repository);

  Future<Either<DoctorFailure, DoctorSuccess>> call(
    Doctor doctor,
  ) {
    return repository.update(doctor);
  }
}

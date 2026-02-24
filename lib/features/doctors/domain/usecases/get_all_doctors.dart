import 'package:osm/core/either.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/doctors/domain/failures/doctor_failure.dart';
import 'package:osm/features/doctors/domain/repositories/doctor_repository.dart';

class GetAllDoctors {
  final DoctorRepository repository;

  GetAllDoctors(this.repository);

  Future<Either<DoctorFailure, List<Doctor>>> call() {
    return repository.getAll();
  }
}
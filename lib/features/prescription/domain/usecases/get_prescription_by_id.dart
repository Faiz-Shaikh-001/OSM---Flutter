import 'package:osm/core/either.dart';
import '../entities/prescription.dart';
import '../failures/prescription_failure.dart';
import '../repositories/prescription_repository.dart';
import 'package:osm/core/value_objects/id.dart';

class GetPrescriptionById {
  final PrescriptionRepository repository;

  GetPrescriptionById(this.repository);

  Future<Either<PrescriptionFailure, Prescription>> call(
    PrescriptionId id,
  ) {
    return repository.getById(id);
  }
}

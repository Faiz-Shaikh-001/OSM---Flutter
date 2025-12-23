import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import '../entities/prescription.dart';
import '../failures/prescription_failure.dart';
import '../repositories/prescription_repository.dart';

class CreatePrescription {
  final PrescriptionRepository repository;

  CreatePrescription(this.repository);

  Future<Either<PrescriptionFailure, PrescriptionId>> call(
    Prescription prescription,
  ) {
    return repository.create(prescription);
  }
}

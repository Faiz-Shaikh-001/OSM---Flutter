import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/prescription/domain/failures/prescription_failure.dart';
import 'package:osm/features/prescription/domain/repositories/prescription_repository.dart';
import 'package:osm/features/prescription/domain/success/prescription_success.dart';

class DeletePrescription {
  final PrescriptionRepository repository;
  DeletePrescription(this.repository);

  Future<Either<PrescriptionFailure, PrescriptionSuccess>> call(
    PrescriptionId prescriptionId,
  ) {
    return repository.delete(prescriptionId);
  }
}

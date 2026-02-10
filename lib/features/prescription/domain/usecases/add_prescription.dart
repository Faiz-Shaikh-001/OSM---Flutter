import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/prescription/domain/success/prescription_success.dart';
import '../entities/prescription.dart';
import '../failures/prescription_failure.dart';
import '../repositories/prescription_repository.dart';

class AddPrescription {
  final PrescriptionRepository repository;

  AddPrescription(this.repository);

  Future<Either<PrescriptionFailure, PrescriptionSuccess>> call(
    Prescription prescription,
    CustomerId customerId,
  ) {
    return repository.add(prescription, customerId);
  }
}

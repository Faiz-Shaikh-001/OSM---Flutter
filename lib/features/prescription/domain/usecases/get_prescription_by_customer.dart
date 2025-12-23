import 'package:osm/core/either.dart';
import '../entities/prescription.dart';
import '../failures/prescription_failure.dart';
import '../repositories/prescription_repository.dart';
import 'package:osm/core/value_objects/id.dart';

class GetPrescriptionsByCustomer {
  final PrescriptionRepository repository;

  GetPrescriptionsByCustomer(this.repository);

  Future<Either<PrescriptionFailure, List<Prescription>>> call(
    CustomerId customerId,
  ) {
    return repository.getByCustomer(customerId);
  }
}

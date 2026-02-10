import 'package:osm/core/either.dart';
import '../entities/prescription.dart';
import '../failures/prescription_failure.dart';
import '../repositories/prescription_repository.dart';
import 'package:osm/core/value_objects/id.dart';

class GetLatestPrescriptions {
  final PrescriptionRepository repository;

  GetLatestPrescriptions(this.repository);

  Future<Either<PrescriptionFailure, Prescription?>> call(
    CustomerId customerId,
  ) {
    return repository.getLatestByCustomer(customerId);
  }
}

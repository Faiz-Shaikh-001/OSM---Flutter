import 'package:osm/core/either.dart';
import 'package:osm/features/prescription/presentation/dto/prescription_with_doctor.dart';
import '../failures/prescription_failure.dart';
import '../repositories/prescription_repository.dart';
import 'package:osm/core/value_objects/id.dart';

class GetPrescriptionHistory {
  final PrescriptionRepository repository;

  GetPrescriptionHistory(this.repository);

  Future<Either<PrescriptionFailure, List<PrescriptionWithDoctor>>> call(
    CustomerId customerId,
  ) {
    return repository.getByCustomerWithDoctor(customerId);
  }
}

import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/prescription/domain/failures/prescription_failure.dart';
import 'package:osm/features/prescription/domain/success/prescription_success.dart';
import 'package:osm/features/prescription/presentation/dto/prescription_with_doctor.dart';
import '../entities/prescription.dart';

abstract class PrescriptionRepository {
  Future<Either<PrescriptionFailure, PrescriptionSuccess>> add(
    Prescription prescription,
    CustomerId customerId,
  );

  Future<Either<PrescriptionFailure, List<Prescription>>> getByCustomer(
    CustomerId customerId,
  );

  Future<Either<PrescriptionFailure, List<PrescriptionWithDoctor>>> getByCustomerWithDoctor(
    CustomerId customerId,
  );

  Future<Either<PrescriptionFailure, Prescription?>> getLatestByCustomer(
    CustomerId customerId,
  );

  Future<Either<PrescriptionFailure, Prescription>> getById(
    PrescriptionId prescriptionId,
  );

  Future<Either<PrescriptionFailure, PrescriptionSuccess>> delete(
    PrescriptionId prescriptionId,
  );
}

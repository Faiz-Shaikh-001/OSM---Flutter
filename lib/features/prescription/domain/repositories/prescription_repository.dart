import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/prescription/domain/failures/prescription_failure.dart';
import '../entities/prescription.dart';

abstract class PrescriptionRepository {
  Future<Either<PrescriptionFailure, PrescriptionId>> create(
    Prescription prescription,
  );

  Future<Either<PrescriptionFailure, Prescription>> getById(PrescriptionId id);

  Future<Either<PrescriptionFailure, List<Prescription>>> getByCustomer(
    CustomerId customerId,
  );

  Future<Either<PrescriptionFailure, List<Prescription>>> getByDoctor(
    DoctorId doctorId,
  );
}

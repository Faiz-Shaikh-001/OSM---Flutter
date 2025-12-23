import 'package:isar/isar.dart';
import 'package:osm/core/either.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/data/models/customer_model.dart';
import 'package:osm/features/doctors/data/models/doctor_model.dart';
import 'package:osm/features/prescription/data/mapper/prescription_mapper.dart';

import 'package:osm/features/prescription/domain/entities/prescription.dart';
import 'package:osm/features/prescription/domain/failures/prescription_failure.dart';
import 'package:osm/features/prescription/domain/repositories/prescription_repository.dart';

import '../models/prescription_model.dart';

class PrescriptionRepositoryImpl implements PrescriptionRepository {
  final IsarService _isarService;

  PrescriptionRepositoryImpl(this._isarService);

  // CREATE
  @override
  Future<Either<PrescriptionFailure, PrescriptionId>> create(
    Prescription prescription,
  ) async {
    try {
      final isar = await _isarService.db;
      final model = PrescriptionMapper.toModel(prescription);

      await isar.writeTxn(() async {
        await isar.prescriptionModels.put(model);
      });

      return Right(PrescriptionId(model.id.toString()));
    } catch (e) {
      return const Left(PrescriptionPersistenceFailure());
    }
  }

  // GET BY ID
  @override
  Future<Either<PrescriptionFailure, Prescription>> getById(
    PrescriptionId id,
  ) async {
    try {
      final isar = await _isarService.db;
      final model = await isar.prescriptionModels.get(int.parse(id.value));

      if (model == null) {
        return const Left(PrescriptionNotFoundFailure());
      }

      return Right(PrescriptionMapper.toDomain(model));
    } catch (e) {
      return const Left(PrescriptionPersistenceFailure());
    }
  }

  // GET BY CUSTOMER
  @override
  Future<Either<PrescriptionFailure, List<Prescription>>> getByCustomer(
    CustomerId customerId,
  ) async {
    try {
      final isar = await _isarService.db;
      final models = await isar.prescriptionModels
          .filter()
          .customer((c) => c.idEqualTo(int.parse(customerId.value)))
          .findAll();

      final prescriptions = models.map(PrescriptionMapper.toDomain).toList();

      return Right(prescriptions);
    } catch (e) {
      return const Left(PrescriptionPersistenceFailure());
    }
  }

  // GET BY DOCTOR
  @override
  Future<Either<PrescriptionFailure, List<Prescription>>> getByDoctor(
    DoctorId doctorId,
  ) async {
    try {
      final isar = await _isarService.db;
      final models = await isar.prescriptionModels
          .filter()
          .doctor((d) => d.idEqualTo(int.parse(doctorId.value)))
          .findAll();

      final prescriptions = models.map(PrescriptionMapper.toDomain).toList();

      return Right(prescriptions);
    } catch (e) {
      return const Left(PrescriptionPersistenceFailure());
    }
  }
}

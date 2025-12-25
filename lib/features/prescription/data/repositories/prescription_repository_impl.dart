import 'package:osm/core/either.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/data/repositories/customer_local_repository.dart';
import 'package:osm/features/doctors/data/mapper/doctor_mapper.dart';
import 'package:osm/features/doctors/data/repositories/doctor_repository.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/prescription/data/mapper/prescription_mapper.dart';
import 'package:osm/features/prescription/data/repositories/prescription_local_repository.dart';

import 'package:osm/features/prescription/domain/entities/prescription.dart';
import 'package:osm/features/prescription/domain/entities/prescription_source.dart';
import 'package:osm/features/prescription/domain/failures/prescription_failure.dart';
import 'package:osm/features/prescription/domain/repositories/prescription_repository.dart';
import 'package:osm/features/prescription/domain/success/prescription_success.dart';

class PrescriptionRepositoryImpl implements PrescriptionRepository {
  final IsarService _isarService;
  final PrescriptionLocalRepository _localRepository;
  final CustomerLocalRepository _customerRepository;
  final DoctorRepositoryImpl _doctorRepository;

  PrescriptionRepositoryImpl(
    this._isarService,
    this._localRepository,
    this._customerRepository,
    this._doctorRepository,
  );

  // CREATE
  @override
  Future<Either<PrescriptionFailure, PrescriptionSuccess>> add(
    Prescription prescription,
    CustomerId customerId,
  ) async {
    try {
      final isar = await _isarService.db;

      if (prescription.source == PrescriptionSource.external &&
          prescription.doctorId == null) {
        return const Left(
          PrescriptionValidationFailure(
            "Doctor is required for external prescriptions",
          ),
        );
      }

      final customerModel = await _customerRepository.getById(
        int.parse(customerId.value),
      );

      if (customerModel == null) {
        return Left(
          PrescriptionCustomerNotFoundFailure(
            "Customer not found to attach prescription",
          ),
        );
      }

      final model = PrescriptionMapper.toModel(
        prescription,
        customer: customerModel,
      );

      if (prescription.doctorId != null) {
        final doctorModel = await _doctorRepository.getById(
          DoctorId(prescription.doctorId!.value),
        );

        model.doctor.value = DoctorMapper.toModel(doctorModel as Doctor);
      }

      await isar.writeTxn(() async {
        await _localRepository.insert(model, customerModel, isar: isar);
      });

      return Right(
        PrescriptionAddedSuccess(PrescriptionId(model.id.toString())),
      );
    } catch (e) {
      return const Left(PrescriptionStorageFailure());
    }
  }

  @override
  Future<Either<PrescriptionFailure, PrescriptionSuccess>> delete(
    PrescriptionId prescriptionId,
  ) async {
    try {
      final isar = await _isarService.db;
      await isar.writeTxn(() async {
        await _localRepository.delete(
          int.parse(prescriptionId.value),
          isar: isar,
        );
      });

      return const Right(PrescriptionDeletedSuccess());
    } catch (e) {
      return const Left(PrescriptionUnknownFailure());
    }
  }

  @override
  Future<Either<PrescriptionFailure, List<Prescription>>> getByCustomer(
    CustomerId customerId,
  ) async {
    try {
      final customerModel = await _customerRepository.getById(
        int.parse(customerId.value),
      );

      if (customerModel == null) {
        return Left(
          PrescriptionCustomerNotFoundFailure(
            "Customer not found for prescription",
          ),
        );
      }

      final models = await _localRepository.getByCustomer(customerModel);

      final entities = models
          .map(PrescriptionMapper.toEntity)
          .toList(growable: false);

      return Right(entities);
    } catch (e) {
      return Left(PrescriptionUnknownFailure());
    }
  }

  @override
  Future<Either<PrescriptionFailure, Prescription?>> getLatestByCustomer(
    CustomerId customerId,
  ) async {
    try {
      final customerModel = await _customerRepository.getById(
        int.parse(customerId.value),
      );

      if (customerModel == null) {
        return Left(
          PrescriptionCustomerNotFoundFailure(
            "Customer not found for prescription",
          ),
        );
      }

      final model = await _localRepository.getLatestByCustomer(customerModel);

      if (model == null) return const Right(null);

      return Right(PrescriptionMapper.toEntity(model));
    } catch (_) {
      return const Left(PrescriptionUnknownFailure());
    }
  }

  @override
  Future<Either<PrescriptionFailure, Prescription>> getById(
    PrescriptionId prescriptionId,
  ) async {
    try {
      final isar = await _isarService.db;
      final model = await _localRepository.getById(
        int.parse(prescriptionId.value),
        isar: isar,
      );
      if (model == null) return Left(PrescriptionNotFoundFailure());
      return Right(PrescriptionMapper.toEntity(model));
    } catch (_) {
      return Left(PrescriptionUnknownFailure());
    }
  }
}

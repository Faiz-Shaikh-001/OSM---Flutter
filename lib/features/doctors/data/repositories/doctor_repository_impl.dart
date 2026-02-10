import 'package:osm/core/either.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/doctors/data/mapper/doctor_mapper.dart';
import 'package:osm/features/doctors/data/repositories/doctor_local_repository.dart';

import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/doctors/domain/failures/doctor_failure.dart';
import 'package:osm/features/doctors/domain/success/doctor_success.dart';
import 'package:osm/features/doctors/domain/repositories/doctor_repository.dart';
import 'package:osm/features/store/data/repositories/store_location_local_repository.dart';

import '../models/doctor_model.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final IsarService _isarService;
  final DoctorLocalRepository _localRepository;
  final StoreLocationLocalRepository _storeLocationLocalRepository;

  DoctorRepositoryImpl(this._isarService, this._localRepository, this._storeLocationLocalRepository);

  // ADD
  @override
  Future<Either<DoctorFailure, DoctorId>> add(Doctor doctor) async {
    try {
      final isar = await _isarService.db;
      final storeLocation = await _storeLocationLocalRepository.getById(
        int.parse(doctor.storeLocationId.value),
        isar,
      );
      final model = DoctorMapper.toModel(doctor);

      final id = await isar.writeTxn(() async {
        await _localRepository.insert(model, isar);
        model.storeLocation.value = storeLocation;
        await model.storeLocation.save();
      });

      return Right(DoctorId(id.toString()));
    } catch (e) {
      return const Left(DoctorPersistenceFailure());
    }
  }

  // GET BY ID
  @override
  Future<Either<DoctorFailure, Doctor>> getById(DoctorId id) async {
    try {
      final isar = await _isarService.db;
      final model = await _localRepository.getById(int.parse(id.value), isar);

      if (model == null) {
        return const Left(DoctorNotFoundFailure());
      }

      return Right(DoctorMapper.toEntity(model));
    } catch (e) {
      return const Left(DoctorPersistenceFailure());
    }
  }

  // GET ALL
  @override
  Future<Either<DoctorFailure, List<Doctor>>> getAll() async {
    try {
      final isar = await _isarService.db;
      final models = await _localRepository.getAll(isar);

      final doctors = models.map(DoctorMapper.toEntity).toList();

      return Right(doctors);
    } catch (e) {
      return const Left(DoctorPersistenceFailure());
    }
  }

  // GET BY STORE LOCATION
  @override
  Future<Either<DoctorFailure, List<Doctor>>> getByStoreLocation(
    StoreLocationId storeLocationId,
  ) async {
    try {
      final isar = await _isarService.db;
      final models = await _localRepository.getByStoreLocation(
        int.parse(storeLocationId.value),
        isar,
      );

      final doctors = models.map(DoctorMapper.toEntity).toList();

      return Right(doctors);
    } catch (e) {
      return const Left(DoctorPersistenceFailure());
    }
  }

  // UPDATE
  @override
  Future<Either<DoctorFailure, DoctorSuccess>> update(Doctor doctor) async {
    try {
      final id = int.parse(doctor.id!.value);
      final isar = await _isarService.db;
      final existing = await isar.doctorModels.get(id);

      if (existing == null) {
        return const Left(DoctorNotFoundFailure());
      }

      final updated = DoctorMapper.toModel(doctor)..id = id;

      await isar.writeTxn(() async {
        await _localRepository.insert(updated, isar);
      });

      return const Right(DoctorUpdatedSuccess());
    } catch (e) {
      return const Left(DoctorPersistenceFailure());
    }
  }

  // DEACTIVATE
  @override
  Future<Either<DoctorFailure, DoctorSuccess>> deactivate(DoctorId id) async {
    try {
      final parsedId = int.parse(id.value);
      final isar = await _isarService.db;
      final existing = await isar.doctorModels.get(parsedId);

      if (existing == null) {
        return const Left(DoctorNotFoundFailure());
      }

      final updated = DoctorModel(
        createdAt: existing.createdAt,
        name: existing.name,
        designation: existing.designation,
        hospital: existing.hospital,
        city: existing.city,
        isActive: false,
        storeLocation: existing.storeLocation,
      )..id = existing.id;

      await isar.writeTxn(() async {
        await _localRepository.insert(updated, isar);
      });

      return const Right(DoctorDeactivatedSuccess());
    } catch (e) {
      return const Left(DoctorPersistenceFailure());
    }
  }
}

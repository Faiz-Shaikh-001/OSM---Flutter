import 'package:isar/isar.dart';
import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/doctors/data/mapper/doctor_mapper.dart';

import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/doctors/domain/failures/doctor_failure.dart';
import 'package:osm/features/doctors/domain/success/doctor_success.dart';
import 'package:osm/features/doctors/domain/repositories/doctor_repository.dart';
import 'package:osm/features/store/data/model/store_location_model.dart';

import '../models/doctor_model.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final Isar isar;

  DoctorRepositoryImpl(this.isar);

  // ADD
  @override
  Future<Either<DoctorFailure, DoctorId>> add(Doctor doctor) async {
    try {
      final model = DoctorMapper.toModel(doctor);

      await isar.writeTxn(() async {
        await isar.doctorModels.put(model);
      });

      return Right(DoctorId(model.id.toString()));
    } catch (e) {
      return const Left(DoctorPersistenceFailure());
    }
  }

  // GET BY ID
  @override
  Future<Either<DoctorFailure, Doctor>> getById(DoctorId id) async {
    try {
      final model = await isar.doctorModels.get(int.parse(id.value));

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
      final models = await isar.doctorModels.where().findAll();

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
      final models = await isar.doctorModels
          .filter()
          .storeLocation((s) => s.idEqualTo(int.parse(storeLocationId.value)))
          .findAll();

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
      final id = int.parse(doctor.id.value);

      final existing = await isar.doctorModels.get(id);

      if (existing == null) {
        return const Left(DoctorNotFoundFailure());
      }

      final updated = DoctorMapper.toModel(doctor)..id = id;

      await isar.writeTxn(() async {
        await isar.doctorModels.put(updated);
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
        await isar.doctorModels.put(updated);
      });

      return const Right(DoctorDeactivatedSuccess());
    } catch (e) {
      return const Left(DoctorPersistenceFailure());
    }
  }
}

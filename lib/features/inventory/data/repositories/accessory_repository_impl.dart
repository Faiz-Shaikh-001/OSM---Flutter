import 'package:isar/isar.dart';
import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/data/mappers/accessory/accessory_mapper.dart';
import 'package:osm/features/inventory/data/models/accessory/accessory_model.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/domain/failures/accessory/accessory_failure.dart';
import 'package:osm/features/inventory/domain/repositories/accessory_repository.dart';
import 'package:osm/features/inventory/domain/success/accessory/accessory_success.dart';

class AccessoryRepositoryImpl implements AccessoryRepository {
  final Isar isar;

  AccessoryRepositoryImpl(this.isar);

  @override
  Future<Either<AccessoryFailure, List<Accessory>>> getAll() async {
    try {
      final models = await isar.accessoryModels.where().findAll();
      return Right(models.map(AccessoryMapper.toEntity).toList());
    } catch (e) {
      return Left(AccessoryStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<AccessoryFailure, Accessory>> getById(AccessoryId id) async {
    try {
      final model = await isar.accessoryModels.get(int.parse(id.value));

      if (model == null) {
        return const Left(AccessoryNotFoundFailure('Accessory not found.'));
      }

      return Right(AccessoryMapper.toEntity(model));
    } catch (e) {
      return Left(AccessoryStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<AccessoryFailure, AccessoryCreatedSuccess>> create(
    Accessory accessory,
  ) async {
    try {
      final model = AccessoryMapper.toModel(accessory);
      final id = await isar.writeTxn(() => isar.accessoryModels.put(model));

      return Right(AccessoryCreatedSuccess(AccessoryId(id.toString())));
    } catch (e) {
      return Left(AccessoryStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<AccessoryFailure, AccessoryDeletedSuccess>> delete(
    AccessoryId id,
  ) async {
    try {
      final success = await isar.writeTxn(
        () => isar.accessoryModels.delete(int.parse(id.value)),
      );

      if (!success) {
        return const Left(AccessoryNotFoundFailure('Accessory not found.'));
      }

      return const Right(AccessoryDeletedSuccess());
    } catch (e) {
      return Left(AccessoryStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<AccessoryFailure, AccessoryUpdatedSuccess>> update(
    Accessory accessory,
  ) async {
    try {
      final model = AccessoryMapper.toModel(accessory)
        ..id = int.parse(accessory.id.value);

      await isar.writeTxn(() => isar.accessoryModels.put(model));

      return const Right(AccessoryUpdatedSuccess());
    } catch (e) {
      return Left(AccessoryStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<AccessoryFailure, List<Accessory>>> getByBrand(
    String brand,
  ) async {
    try {
      final models = await isar.accessoryModels
          .filter()
          .brandEqualTo(brand, caseSensitive: false)
          .findAll();

      return Right(models.map(AccessoryMapper.toEntity).toList());
    } catch (e) {
      return Left(AccessoryStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<AccessoryFailure, List<Accessory>>> getByName(
    String name,
  ) async {
    try {
      final models = await isar.accessoryModels
          .filter()
          .nameContains(name, caseSensitive: false)
          .findAll();

      return Right(models.map(AccessoryMapper.toEntity).toList());
    } catch (e) {
      return Left(AccessoryStorageFailure(e.toString()));
    }
  }
}

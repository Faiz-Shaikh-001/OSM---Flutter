import 'package:osm/core/either.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/data/mappers/accessory/accessory_mapper.dart';
import 'package:osm/features/inventory/data/repositories/accessory_local_repository.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/domain/failures/accessory/accessory_failure.dart';
import 'package:osm/features/inventory/domain/repositories/accessory_repository.dart';
import 'package:osm/features/inventory/domain/success/accessory/accessory_success.dart';

class AccessoryRepositoryImpl implements AccessoryRepository {
  final IsarService _isarService;
  final AccessoryLocalRepository _localRepository;

  AccessoryRepositoryImpl(this._isarService, this._localRepository);

  @override
  Future<Either<AccessoryFailure, List<Accessory>>> getAll() async {
    try {
      final isar = await _isarService.db;

      final models = await _localRepository.getAll(isar);

      final entities = models.map(AccessoryMapper.toEntity).toList();

      return Right(entities);
    } catch (e) {
      return Left(AccessoryStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<AccessoryFailure, Accessory>> getById(AccessoryId id) async {
    try {
      final isar = await _isarService.db;

      final model = await _localRepository.getById(int.parse(id.value), isar);

      if (model == null) {
        return const Left(AccessoryNotFoundFailure());
      }

      final entity = AccessoryMapper.toEntity(model);

      return Right(entity);
    } catch (e) {
      return Left(AccessoryStorageFailure(e.toString()));
    }
  }

  @override
  Future<Accessory?> getByQrKey(String qrKey) async {
    try {
      final isar = await _isarService.db;
      final model = await _localRepository.getByQrKey(qrKey, isar);

      if (model == null) {
        return null;
      }

      return AccessoryMapper.toEntity(model);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Either<AccessoryFailure, AccessoryCreatedSuccess>> create(
    Accessory accessory,
  ) async {
    try {
      final isar = await _isarService.db;
      final model = AccessoryMapper.toModel(accessory);

      final id = await isar.writeTxn(() async {
        await _localRepository.insert(model, isar);
      });

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
      final isar = await _isarService.db;
      final success = await isar.writeTxn(() async {
        await _localRepository.delete(int.parse(id.value), isar);
      });

      if (!success) {
        return const Left(AccessoryNotFoundFailure());
      }

      return Right(AccessoryDeletedSuccess("Accessory deleted successfully."));
    } catch (e) {
      return Left(AccessoryStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<AccessoryFailure, AccessoryUpdatedSuccess>> update(
    Accessory accessory,
  ) async {
    try {
      final isar = await _isarService.db;
      final model = AccessoryMapper.toModel(accessory)
        ..id = int.parse(accessory.id!.value);

      await isar.writeTxn(() async {
        await _localRepository.insert(model, isar);
      });

      return Right(AccessoryUpdatedSuccess("Accessory updated successfully."));
    } catch (e) {
      return Left(AccessoryStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<AccessoryFailure, List<Accessory>>> getByBrand(
    String brand,
  ) async {
    try {
      final isar = await _isarService.db;

      final models = await _localRepository.getByBrand(brand, isar);

      final entities = models.map(AccessoryMapper.toEntity).toList();

      return Right(entities);
    } catch (e) {
      return Left(AccessoryStorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<AccessoryFailure, List<Accessory>>> getByName(
    String name,
  ) async {
    try {
      final isar = await _isarService.db;

      final models = await _localRepository.getByName(name, isar);

      final entities = models.map(AccessoryMapper.toEntity).toList();

      return Right(entities);
    } catch (e) {
      return Left(AccessoryStorageFailure(e.toString()));
    }
  }
}

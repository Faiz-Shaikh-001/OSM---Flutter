import 'package:isar/isar.dart';
import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/store/data/mapper/store_location_mapper.dart';
import 'package:osm/features/store/data/model/active_store_model.dart';
import 'package:osm/features/store/data/model/store_location_model.dart';
import 'package:osm/features/store/domain/entities/store_location.dart';
import 'package:osm/features/store/domain/failures/store_location_failure.dart';
import 'package:osm/features/store/domain/repositories/store_location_repository.dart';
import 'package:osm/features/store/domain/success/store_location_success.dart';

class StoreLocationRepositoryImpl implements StoreLocationRepository {
  final Isar isar;

  StoreLocationRepositoryImpl(this.isar);

  // Get all store locations
  @override
  Future<Either<StoreLocationFailure, List<StoreLocation>>> getAll() async {
    try {
      final models = await isar.storeLocationModels.where().findAll();

      final entities = models.map(StoreLocationMapper.toDomain).toList();

      return Right(entities);
    } catch (e) {
      return Left(StoreFailure('Failed to load store locations'));
    }
  }

  // Get store by ID
  @override
  Future<Either<StoreLocationFailure, StoreLocation>> getById(
    StoreLocationId id,
  ) async {
    try {
      final model = await isar.storeLocationModels.get(int.parse(id.value));

      if (model == null) {
        return const Left(StoreNotFoundFailure());
      }

      return Right(StoreLocationMapper.toDomain(model));
    } catch (e) {
      return Left(StoreFailure('Failed to fetch store'));
    }
  }

  // Get active store location
  @override
  Future<Either<StoreLocationFailure, StoreLocation>> getActive() async {
    try {
      final active = await isar.activeStoreModels.get(1);

      if (active == null) {
        return const Left(NoActiveStoreFailure());
      }

      final store = await isar.storeLocationModels.get(active.storeLocationId);

      if (store == null) {
        return const Left(StoreNotFoundFailure());
      }

      return Right(StoreLocationMapper.toDomain(store));
    } catch (e) {
      return Left(StoreFailure('Failed to get active store'));
    }
  }

  // Set active store location
  @override
  Future<Either<StoreLocationFailure, StoreLocationSuccess>> setActive(
    StoreLocationId id,
  ) async {
    try {
      final store = await isar.storeLocationModels.get(int.parse(id.value));

      if (store == null) {
        return const Left(StoreNotFoundFailure());
      }

      await isar.writeTxn(() async {
        await isar.activeStoreModels.put(
          ActiveStoreModel(storeLocationId: store.id),
        );
      });

      return Right(StoreLocationSuccess());
    } catch (e) {
      return Left(StoreFailure('Failed to set active store'));
    }
  }

  @override
  Future<Either<StoreLocationFailure, StoreLocationId>> add(
    StoreLocation storeLocation,
  ) async {
    try {
      final model = StoreLocationMapper.toModel(storeLocation);

      await isar.writeTxn(() async {
        await isar.storeLocationModels.put(model);
      });

      return Right(StoreLocationId(model.id.toString()));
    } catch (e) {
      return const Left(StoreFailure('Failed to add store location'));
    }
  }

  @override
  Future<Either<StoreLocationFailure, StoreLocationSuccess>> delete(
    StoreLocationId id,
  ) async {
    try {
      final parsedId = int.parse(id.value);

      final exists = await isar.storeLocationModels.get(parsedId);

      if (exists == null) {
        return const Left(StoreNotFoundFailure());
      }

      await isar.writeTxn(() async {
        await isar.storeLocationModels.delete(parsedId);
      });

      return Right(StoreLocationSuccess());
    } catch (e) {
      return const Left(StoreFailure('Failed to delete store location'));
    }
  }

  @override
  Future<Either<StoreLocationFailure, StoreLocationSuccess>> update(
    StoreLocation storeLocation,
  ) async {
    try {
      final id = int.parse(storeLocation.id.value);

      final existing = await isar.storeLocationModels.get(id);

      if (existing == null) {
        return const Left(StoreNotFoundFailure());
      }

      final updated = StoreLocationMapper.toModel(storeLocation)..id = id;

      await isar.writeTxn(() async {
        await isar.storeLocationModels.put(updated);
      });

      return Right(StoreLocationSuccess());
    } catch (e) {
      return const Left(StoreFailure('Failed to update store location'));
    }
  }
}

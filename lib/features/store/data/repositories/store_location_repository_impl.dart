import 'package:osm/core/either.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/store/data/mapper/store_location_mapper.dart';
import 'package:osm/features/store/data/model/active_store_model.dart';
import 'package:osm/features/store/data/model/store_location_model.dart';
import 'package:osm/features/store/data/repositories/store_location_local_repository.dart';
import 'package:osm/features/store/domain/entities/store_location.dart';
import 'package:osm/features/store/domain/failures/store_location_failure.dart';
import 'package:osm/features/store/domain/repositories/store_location_repository.dart';
import 'package:osm/features/store/domain/success/store_location_success.dart';

class StoreLocationRepositoryImpl implements StoreLocationRepository {
  final IsarService _isarService;
  final StoreLocationLocalRepository _localRepository;

  StoreLocationRepositoryImpl(this._isarService, this._localRepository);

  // Get all store locations
  @override
  Future<Either<StoreLocationFailure, List<StoreLocation>>> getAll() async {
    try {
      final isar = await _isarService.db;
      final models = await _localRepository.getAll(isar);

      final entities = models.map(StoreLocationMapper.toEntity).toList();

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
      final isar = await _isarService.db;
      final model = await _localRepository.getById(int.parse(id.value), isar);

      if (model == null) {
        return const Left(StoreNotFoundFailure());
      }

      return Right(StoreLocationMapper.toEntity(model));
    } catch (e) {
      return Left(StoreFailure('Failed to fetch store'));
    }
  }

  // Get active store location
  @override
  Future<Either<StoreLocationFailure, StoreLocation>> getActive() async {
    try {
      final isar = await _isarService.db;
      final active = await _localRepository.getActive(1, isar);

      if (active == null) {
        return const Left(NoActiveStoreFailure());
      }

      final store = await _localRepository.getById(
        active.storeLocationId,
        isar,
      );

      if (store == null) {
        return const Left(StoreNotFoundFailure());
      }

      return Right(StoreLocationMapper.toEntity(store));
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
      final isar = await _isarService.db;
      final store = await _localRepository.getById(int.parse(id.value), isar);

      if (store == null) {
        return const Left(StoreNotFoundFailure());
      }

      await isar.writeTxn(() async {
        _localRepository.setActive(
          ActiveStoreModel(storeLocationId: store.id),
          isar,
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
      final isar = await _isarService.db;
      final model = StoreLocationMapper.toModel(storeLocation);

      await isar.writeTxn(() async {
        await _localRepository.insert(model, isar);
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
      final isar = await _isarService.db;
      final parsedId = int.parse(id.value);

      final exists = await _localRepository.getById(parsedId, isar);

      if (exists == null) {
        return const Left(StoreNotFoundFailure());
      }

      await isar.writeTxn(() async {
        await _localRepository.delete(parsedId, isar);
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
      final isar = await _isarService.db;
      final id = int.parse(storeLocation.id!.value);

      final existing = await _localRepository.getById(id, isar);

      if (existing == null) {
        return const Left(StoreNotFoundFailure());
      }

      final updated = StoreLocationMapper.toModel(storeLocation)..id = id;

      await isar.writeTxn(() async {
        await _localRepository.insert(updated, isar);
      });

      return Right(StoreLocationSuccess());
    } catch (e) {
      return const Left(StoreFailure('Failed to update store location'));
    }
  }

  Future<void> seedStoreIfNeeded() async {
    final isar = await _isarService.db;

    final count = await isar.storeLocationModels.count();
    if (count > 0) return;

    final model = StoreLocationModel(
      name: 'Main Store',
      address: 'Default Address',
      city: 'Default City',
      phoneNumber: '0000000000',
      operatingHours: '9:00 AM - 9:00 PM',
      createdAt: DateTime.now(),
    );

    await isar.writeTxn(() async {
      final storeId = await isar.storeLocationModels.put(model);

      await isar.activeStoreModels.put(
        ActiveStoreModel(storeLocationId: storeId),
      );
    });
  }
}

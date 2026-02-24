import 'package:osm/core/either.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/dashboard/data/models/activity_model.dart';
import 'package:osm/features/dashboard/data/repositories/activity_local_repository.dart';
import 'package:osm/features/dashboard/domain/entities/activity.dart';
import 'package:osm/features/inventory/data/mappers/lens/lens_enum_mappers.dart';
import 'package:osm/features/inventory/data/mappers/lens/lens_mapper.dart';
import 'package:osm/features/inventory/data/repositories/lens_local_repository.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens_type.dart';
import 'package:osm/features/inventory/domain/failures/lens/lens_failure.dart';
import 'package:osm/features/inventory/domain/repositories/lens_repository.dart';
import 'package:osm/features/inventory/domain/success/lens/lens_success.dart';

class LensRepositoryImpl implements LensRepository {
  final IsarService _isarService;
  final LensLocalRepository _localRepository;
  final ActivityLocalRepository _activityLocalRepository;

  LensRepositoryImpl(
    this._isarService,
    this._localRepository,
    this._activityLocalRepository,
  );

  @override
  Future<Either<LensFailure, Lens>> getById(LensId id) async {
    try {
      final isar = await _isarService.db;
      final model = await _localRepository.getById(int.parse(id.value), isar);

      if (model == null) {
        return Left(LensNotFoundFailure());
      }

      return Right(LensMapper.toEntity(model));
    } catch (e) {
      return Left(LensUnexpectedFailure());
    }
  }

  @override
  Future<Either<LensFailure, List<Lens>>> getAll() async {
    try {
      final isar = await _isarService.db;
      final models = await _localRepository.getAll(isar);
      final entities = models.map(LensMapper.toEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(LensUnexpectedFailure());
    }
  }

  @override
  Future<Either<LensFailure, List<Lens>>> getByCompany(
    String companyName,
  ) async {
    try {
      final isar = await _isarService.db;
      final models = await _localRepository.getByCompany(companyName, isar);
      final entities = models.map(LensMapper.toEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(LensUnexpectedFailure());
    }
  }

  @override
  Future<Either<LensFailure, List<Lens>>> getByProductName(
    String productName,
  ) async {
    try {
      final isar = await _isarService.db;
      final models = await _localRepository.getByProductName(productName, isar);
      final entities = models.map(LensMapper.toEntity).toList();

      return Right(entities);
    } catch (e) {
      return Left(LensUnexpectedFailure());
    }
  }

  @override
  Future<Either<LensFailure, List<Lens>>> getByType(LensType lensType) async {
    try {
      final isar = await _isarService.db;
      final type = LensEnumMapper.toModelLensType(lensType);
      final models = await _localRepository.getByType(type, isar);
      final entities = models.map(LensMapper.toEntity).toList();

      return Right(entities);
    } catch (e) {
      return Left(LensUnexpectedFailure());
    }
  }

  @override
  Future<Lens?> getByQrKey(String qrKey) async {
    try {
      final isar = await _isarService.db;
      final model = await _localRepository.getByQrKey(qrKey, isar);

      if (model == null) {
        return null;
      }

      return LensMapper.toEntity(model);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Either<LensFailure, LensCreatedSuccess>> create(Lens lens) async {
    try {
      final isar = await _isarService.db;
      final model = LensMapper.toModel(lens);

      final id = await isar.writeTxn(() async {
        final newId = await _localRepository.insert(model, isar);

        final activity = Activity(
          type: ActivityType.newStockAdded,
          occurredAt: DateTime.now(),
          metadata: {
            'productId': newId.toString(),
            'productName': lens.productName,
            'company': lens.companyName,
            'category': 'Lens',
          },
        );
        await _activityLocalRepository.log(
          ActivityModel.fromEntity(activity),
          isar: isar,
        );

        return newId;
      });

      return Right(LensCreatedSuccess(LensId(id.toString())));
    } catch (e) {
      return Left(LensUnexpectedFailure());
    }
  }

  @override
  Future<Either<LensFailure, LensUpdatedSuccess>> update(Lens lens) async {
    try {
      final isar = await _isarService.db;
      final exists = await _localRepository.getById(
        int.parse(lens.id!.value),
        isar,
      );

      if (exists == null) {
        return Left(LensNotFoundFailure());
      }

      final model = LensMapper.toModel(lens);

      final id = await isar.writeTxn(() async {
        final updatedId = await _localRepository.update(model, isar);

        final activity = Activity(
          type: ActivityType.stockUpdated,
          occurredAt: DateTime.now(),
          metadata: {
            'productId': lens.id!.value,
            'productName': lens.productName,
            'company': lens.companyName,
          },
        );
        await _activityLocalRepository.log(
          ActivityModel.fromEntity(activity),
          isar: isar,
        );

        return updatedId;
      });

      return Right(LensUpdatedSuccess(LensId(id.toString())));
    } catch (e) {
      return Left(LensUnexpectedFailure());
    }
  }

  @override
  Future<Either<LensFailure, LensDeletedSuccess>> delete(LensId id) async {
    try {
      final isar = await _isarService.db;

      final existingModel = await _localRepository.getById(
        int.parse(id.value),
        isar,
      );

      final String lensName =
          "${existingModel?.companyName ?? "Unknown"} ${existingModel?.productName ?? "Unknown"}";

      final success = await isar.writeTxn(() async {
        return await _localRepository.delete(int.parse(id.value), isar);
      });

      if (!success) {
        return Left(LensNotFoundFailure());
      }

      final activity = Activity(
        type: ActivityType.stockDeleted,
        occurredAt: DateTime.now(),
        metadata: {'lensId': id.value, 'name': lensName, 'action': 'Deleted'},
      );

      await isar.writeTxn(() async {
        await _activityLocalRepository.log(
          ActivityModel.fromEntity(activity),
          isar: isar,
        );
      });

      return Right(LensDeletedSuccess(success));
    } catch (e) {
      return Left(LensUnexpectedFailure());
    }
  }
}

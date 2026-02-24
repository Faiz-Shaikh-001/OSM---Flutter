import 'package:osm/core/either.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/dashboard/data/models/activity_model.dart';
import 'package:osm/features/dashboard/data/repositories/activity_local_repository.dart';
import 'package:osm/features/dashboard/domain/entities/activity.dart';
import 'package:osm/features/inventory/data/mappers/frame/frame_enum_mappers.dart';
import 'package:osm/features/inventory/data/mappers/frame/frame_mapper.dart';
import 'package:osm/features/inventory/data/repositories/frame_local_repository.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame_type.dart';
import 'package:osm/features/inventory/domain/failures/frames/frame_failure.dart';
import 'package:osm/features/inventory/domain/success/frames/frame_success.dart';
import 'package:osm/features/inventory/domain/repositories/frame_repository.dart';
import 'package:osm/features/inventory/data/models/frame/frame_model.dart';

class FrameRepositoryImpl implements FrameRepository {
  final IsarService _isarService;
  final FrameLocalRepository _localRepository;
  final ActivityLocalRepository _activityLocalRepository;

  FrameRepositoryImpl(
    this._isarService,
    this._localRepository,
    this._activityLocalRepository,
  );

  @override
  Future<Either<FrameFailure, Frame>> getById(FrameId id) async {
    try {
      final isar = await _isarService.db;
      final model = await _localRepository.getById(int.parse(id.value), isar);

      if (model == null) {
        return Left(FrameNotFoundFailure());
      }

      return Right(FrameMapper.toEntity(model));
    } catch (e) {
      return Left(FrameUnexpectedFailure("Frame unexpected failure"));
    }
  }

  @override
  Future<Either<FrameFailure, List<Frame>>> getAll() async {
    try {
      final isar = await _isarService.db;
      final models = await _localRepository.getAll(isar);
      final entities = models.map((m) => FrameMapper.toEntity(m)).toList();
      return Right(entities);
    } catch (e) {
      return Left(FrameUnexpectedFailure("Frame unexpected failure"));
    }
  }

  @override
  Future<Either<FrameFailure, List<Frame>>> getByCompany(
    String companyName,
  ) async {
    try {
      final isar = await _isarService.db;
      final models = await _localRepository.getByCompany(companyName, isar);

      return Right(models.map((e) => FrameMapper.toEntity(e)).toList());
    } catch (e) {
      return Left(FrameUnexpectedFailure("Frame unexpected failure"));
    }
  }

  @override
  Future<Either<FrameFailure, List<Frame>>> getByName(String name) async {
    try {
      final isar = await _isarService.db;
      final models = await _localRepository.getByName(name, isar);

      return Right(models.map((e) => FrameMapper.toEntity(e)).toList());
    } catch (e) {
      return Left(FrameUnexpectedFailure("Frame unexpected failure"));
    }
  }

  @override
  Future<Either<FrameFailure, List<Frame>>> getByType(
    FrameType frameType,
  ) async {
    try {
      final isar = await _isarService.db;

      final type = FrameEnumMapper.toModel(frameType);

      final models = await _localRepository.getByType(type, isar);

      return Right(models.map((e) => FrameMapper.toEntity(e)).toList());
    } catch (e) {
      return Left(FrameUnexpectedFailure("Frame unexpected failure"));
    }
  }

  @override
  Future<Frame?> getByQrKey(String qrKey) async {
    try {
      final isar = await _isarService.db;
      final model = await _localRepository.getByQrKey(qrKey, isar);

      if (model == null) {
        return null;
      }

      return FrameMapper.toEntity(model);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Either<FrameFailure, FrameCreatedSuccess>> create(Frame frame) async {
    try {
      final isar = await _isarService.db;
      final model = FrameMapper.toModel(frame);

      final id = await isar.writeTxn(() async {
        final newId = await _localRepository.insert(model, isar);

        final activity = Activity(
          type: ActivityType.newStockAdded,
          occurredAt: DateTime.now(),
          metadata: {
            'productId': newId.toString(),
            'name': frame.name,
            'brand': frame.companyName,
            'category': 'Frame',
          },
        );
        await _activityLocalRepository.log(
          ActivityModel.fromEntity(activity),
          isar: isar,
        );

        return newId;
      });

      return Right(FrameCreatedSuccess(FrameId(id.toString())));
    } catch (e) {
      return Left(FrameUnexpectedFailure("Frame unexpected failure"));
    }
  }

  @override
  Future<Either<FrameFailure, FrameUpdatedSuccess>> update(Frame frame) async {
    try {
      final isar = await _isarService.db;
      final exists = await isar.frameModels.get(int.parse(frame.id!.value));

      if (exists == null) {
        return Left(FrameNotFoundFailure());
      }

      final model = FrameMapper.toModel(frame);

      final id = await isar.writeTxn(() async {
        final updatedId = await _localRepository.update(model, isar);

        final activity = Activity(
          type: ActivityType.stockUpdated,
          occurredAt: DateTime.now(),
          metadata: {
            'productId': frame.id!.value,
            'name': frame.name,
            'brand': frame.companyName,
          },
        );
        await _activityLocalRepository.log(
          ActivityModel.fromEntity(activity),
          isar: isar,
        );

        return updatedId;
      });

      return Right(FrameUpdatedSuccess(FrameId(id.toString())));
    } catch (e) {
      return Left(FrameUnexpectedFailure("Frame unexpected failure"));
    }
  }

  @override
  Future<Either<FrameFailure, FrameDeletedSuccess>> delete(FrameId id) async {
    try {
      final isar = await _isarService.db;

      final existing = await _localRepository.getById(
        int.parse(id.value),
        isar,
      );
      final frameName = existing?.name ?? "Unknown Frame";

      final success = await isar.writeTxn(() async {
        return await _localRepository.delete(int.parse(id.value), isar);
      });

      if (!success) {
        return Left(FrameNotFoundFailure());
      }

      final activity = Activity(
        type: ActivityType.stockDeleted,
        occurredAt: DateTime.now(),
        metadata: {'productId': id.value, 'name': frameName},
      );
      await _activityLocalRepository.log(
        ActivityModel.fromEntity(activity),
        isar: isar,
      );

      return Right(FrameDeletedSuccess(success));
    } catch (e) {
      return Left(FrameUnexpectedFailure("Frame unexpected failure"));
    }
  }
}

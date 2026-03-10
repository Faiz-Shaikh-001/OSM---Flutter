import 'package:isar/isar.dart';
import 'package:osm/core/either.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/staff/data/mapper/staff_mapper.dart';
import 'package:osm/features/staff/data/models/staff_model.dart';
import 'package:osm/features/staff/domain/entities/staff.dart';
import 'package:osm/features/staff/domain/repositories/staff_repository.dart';

class StaffRepositoryImpl implements StaffRepository {
  final IsarService _isarService;

  StaffRepositoryImpl(this._isarService);

  @override
  Future<Either<String, List<Staff>>> getAll() async {
    try {
      final isar = await _isarService.db;

      final models = await isar.staffModels.where().findAll();

      final entities = models.map(StaffMapper.toEntity).toList();

      return Right(entities);
    } catch (e) {
      return const Left('Failed to load staff');
    }
  }

  @override
  Future<Either<String, List<Staff>>> getByStore(StoreLocationId storeId) async {
    try {
      final isar = await _isarService.db;

      final models = await isar.staffModels
          .filter()
          .storeIdEqualTo(int.parse(storeId.value))
          .findAll();

      final entities = models.map(StaffMapper.toEntity).toList();

      return Right(entities);
    } catch (e) {
      return const Left('Failed to load staff for store');
    }
  }

  @override
  Future<Either<String, StaffId>> add(Staff staff) async {
    try {
      final isar = await _isarService.db;

      final model = StaffMapper.toModel(staff);

      await isar.writeTxn(() async {
        await isar.staffModels.put(model);
      });

      return Right(StaffId(model.id.toString()));
    } catch (e) {
      return const Left('Failed to add staff');
    }
  }

  @override
  Future<Either<String, void>> update(Staff staff) async {
    try {
      final isar = await _isarService.db;

      final model = StaffMapper.toModel(staff);

      await isar.writeTxn(() async {
        await isar.staffModels.put(model);
      });

      return const Right(null);
    } catch (e) {
      return const Left('Failed to update staff');
    }
  }

  @override
  Future<Either<String, void>> delete(StaffId id) async {
    try {
      final isar = await _isarService.db;

      await isar.writeTxn(() async {
        await isar.staffModels.delete(int.parse(id.value));
      });

      return const Right(null);
    } catch (e) {
      return const Left('Failed to delete staff');
    }
  }
}
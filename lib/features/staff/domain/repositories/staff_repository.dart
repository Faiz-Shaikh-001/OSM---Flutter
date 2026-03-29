import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/staff/domain/entities/staff.dart';

abstract class StaffRepository {
  /// Get all staff
  Future<Either<String, List<Staff>>> getAll();

  /// Get staff belonging to a specific store
  Future<Either<String, List<Staff>>> getByStore(StoreLocationId storeId);

  /// Add new staff
  Future<Either<String, StaffId>> add(Staff staff);

  /// Update staff
  Future<Either<String, void>> update(Staff staff);

  /// Delete staff
  Future<Either<String, void>> delete(StaffId id);
}
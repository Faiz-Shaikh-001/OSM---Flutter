import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import '../failures/accessory/accessory_failure.dart';
import '../success/accessory/accessory_success.dart';

abstract class AccessoryRepository {
  Future<Either<AccessoryFailure, List<Accessory>>> getAll();

  Future<Either<AccessoryFailure, Accessory>> getById(
    AccessoryId id,
  );

  Future<Either<AccessoryFailure, List<Accessory>>> getByBrand(
    String brand,
  );

  Future<Either<AccessoryFailure, List<Accessory>>> getByName(
    String name,
  );

  Future<Either<AccessoryFailure, AccessoryCreatedSuccess>> create(
    Accessory accessory,
  );

  Future<Either<AccessoryFailure, AccessoryUpdatedSuccess>> update(
    Accessory accessory,
  );

  Future<Either<AccessoryFailure, AccessoryDeletedSuccess>> delete(
    AccessoryId id,
  );
}

import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/store/domain/failures/store_location_failure.dart';
import 'package:osm/features/store/domain/success/store_location_success.dart';
import '../entities/store_location.dart';

abstract class StoreLocationRepository {
  Future<Either<StoreLocationFailure, List<StoreLocation>>> getAll();

  Future<Either<StoreLocationFailure, StoreLocation>> getById(
    StoreLocationId id,
  );

  Future<Either<StoreLocationFailure, StoreLocation>> getActive();

  Future<Either<StoreLocationFailure, StoreLocationSuccess>> setActive(
    StoreLocationId id,
  );

  Future<Either<StoreLocationFailure, StoreLocationId>> add(
    StoreLocation storeLocation,
  );

  Future<Either<StoreLocationFailure, StoreLocationSuccess>> delete(
    StoreLocationId id,
  );

  Future<Either<StoreLocationFailure, StoreLocationSuccess>> update(
    StoreLocation storeLocation,
  );
}

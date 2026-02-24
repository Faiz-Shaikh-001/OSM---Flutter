import 'package:osm/core/either.dart';
import 'package:osm/features/store/domain/entities/store_location.dart';
import 'package:osm/features/store/domain/failures/store_location_failure.dart';
import 'package:osm/features/store/domain/repositories/store_location_repository.dart';
import 'package:osm/features/store/domain/success/store_location_success.dart';

class UpdateStoreLocation {
  final StoreLocationRepository repository;

  UpdateStoreLocation(this.repository);

  Future<Either<StoreLocationFailure, StoreLocationSuccess>> call(
    StoreLocation store,
  ) {
    return repository.update(store);
  }
}
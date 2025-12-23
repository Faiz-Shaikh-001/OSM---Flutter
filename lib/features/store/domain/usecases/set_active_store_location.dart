import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/store/domain/failures/store_location_failure.dart';
import 'package:osm/features/store/domain/success/store_location_success.dart';

import '../repositories/store_location_repository.dart';

class SetActiveStoreLocation {
  final StoreLocationRepository repository;

  SetActiveStoreLocation(this.repository);

  Future<Either<StoreLocationFailure, StoreLocationSuccess>> call(
    StoreLocationId id,
  ) {
    return repository.setActive(id);
  }
}

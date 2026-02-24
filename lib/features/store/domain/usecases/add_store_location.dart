import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/store/domain/entities/store_location.dart';
import 'package:osm/features/store/domain/failures/store_location_failure.dart';
import 'package:osm/features/store/domain/repositories/store_location_repository.dart';

class AddStoreLocation {
  final StoreLocationRepository repository;

  AddStoreLocation(this.repository);

  Future<Either<StoreLocationFailure, StoreLocationId>> call(
    StoreLocation store,
  ) {
    return repository.add(store);
  }
}
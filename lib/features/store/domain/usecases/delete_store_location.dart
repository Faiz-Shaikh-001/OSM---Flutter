import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/store/domain/failures/store_location_failure.dart';
import 'package:osm/features/store/domain/repositories/store_location_repository.dart';
import 'package:osm/features/store/domain/success/store_location_success.dart';

class DeleteStoreLocation {
  final StoreLocationRepository repository;

  DeleteStoreLocation(this.repository);

  Future<Either<StoreLocationFailure, StoreLocationSuccess>> call(
    StoreLocationId id,
  ) {
    return repository.delete(id);
  }
}
import 'package:osm/core/either.dart';
import 'package:osm/features/store/domain/entities/store_location.dart';
import 'package:osm/features/store/domain/failures/store_location_failure.dart';
import 'package:osm/features/store/domain/repositories/store_location_repository.dart';

class GetStoreLocations {
  final StoreLocationRepository repository;
  GetStoreLocations(this.repository);

  Future<Either<StoreLocationFailure, StoreLocation>> call() {
    return repository.getActive();
  }
}

import 'package:osm/core/either.dart';
import 'package:osm/features/store/domain/failures/store_location_failure.dart';

import '../entities/store_location.dart';
import '../repositories/store_location_repository.dart';


class EnsureActiveStoreLocation {
  final StoreLocationRepository repository;

  EnsureActiveStoreLocation(this.repository);

  Future<Either<StoreLocationFailure, StoreLocation>> call() async {
    final activeResult = await repository.getActive();

    return await activeResult.fold(
      (_) async {
        final allResult = await repository.getAll();

        return allResult.fold(
          (_) => const Left(NoStoreLocationsFailure()),

          (stores) async {
            final first = stores.first;
            final setResult =
                await repository.setActive(first.id);

            return setResult.fold(
              (f) => Left(f),
              (_) => Right(first),
            );
          },
        );
      },

      (store) => Right(store),
    );
  }
}

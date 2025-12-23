import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/failures/lens/lens_failure.dart';
import 'package:osm/features/inventory/domain/repositories/lens_repository.dart';

class GetLensById {
  final LensRepository repository;

  GetLensById(this.repository);

  Future<Either<LensFailure, Lens>> call(
    LensId id,
  ) {
    return repository.getById(id);
  }
}

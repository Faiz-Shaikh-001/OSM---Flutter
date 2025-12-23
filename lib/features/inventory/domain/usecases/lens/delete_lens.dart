import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/failures/lens/lens_failure.dart';
import 'package:osm/features/inventory/domain/repositories/lens_repository.dart';
import 'package:osm/features/inventory/domain/success/lens/lens_success.dart';

class DeleteLens {
  final LensRepository repository;

  DeleteLens(this.repository);

  Future<Either<LensFailure, LensDeletedSuccess>> call(
    LensId id,
  ) {
    return repository.delete(id);
  }
}

import 'package:osm/core/either.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens_type.dart';
import 'package:osm/features/inventory/domain/failures/lens/lens_failure.dart';
import 'package:osm/features/inventory/domain/repositories/lens_repository.dart';

class GetLensesByType {
  final LensRepository repository;

  GetLensesByType(this.repository);

  Future<Either<LensFailure, List<Lens>>> call(
    LensType lensType,
  ) {
    return repository.getByType(lensType);
  }
}

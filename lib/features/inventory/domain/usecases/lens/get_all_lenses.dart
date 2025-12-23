import 'package:osm/core/either.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/failures/lens/lens_failure.dart';
import 'package:osm/features/inventory/domain/repositories/lens_repository.dart';

class GetAllLenses {
  final LensRepository repository;

  GetAllLenses(this.repository);

  Future<Either<LensFailure, List<Lens>>> call() {
    return repository.getAll();
  }
}

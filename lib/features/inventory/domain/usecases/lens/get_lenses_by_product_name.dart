import 'package:osm/core/either.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/failures/lens/lens_failure.dart';
import 'package:osm/features/inventory/domain/repositories/lens_repository.dart';

class GetLensesByProductName {
  final LensRepository repository;

  GetLensesByProductName(this.repository);

  Future<Either<LensFailure, List<Lens>>> call(
    String productName,
  ) {
    return repository.getByProductName(productName);
  }
}

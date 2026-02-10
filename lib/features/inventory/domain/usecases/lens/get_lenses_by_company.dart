import 'package:osm/core/either.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/failures/lens/lens_failure.dart';
import 'package:osm/features/inventory/domain/repositories/lens_repository.dart';

class GetLensesByCompany {
  final LensRepository repository;

  GetLensesByCompany(this.repository);

  Future<Either<LensFailure, List<Lens>>> call(
    String companyName,
  ) {
    return repository.getByCompany(companyName);
  }
}

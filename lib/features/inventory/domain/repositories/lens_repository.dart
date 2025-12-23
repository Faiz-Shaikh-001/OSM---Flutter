import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens_type.dart';
import 'package:osm/features/inventory/domain/failures/lens/lens_failure.dart';
import 'package:osm/features/inventory/domain/success/lens/lens_success.dart';

abstract class LensRepository {
  /// Identity
  Future<Either<LensFailure, Lens>> getById(LensId id);

  /// Collection
  Future<Either<LensFailure, List<Lens>>> getAll();

  /// Queries (Firebase / Isar friendly)
  Future<Either<LensFailure, List<Lens>>> getByCompany(
    String companyName,
  );

  Future<Either<LensFailure, List<Lens>>> getByProductName(
    String productName,
  );

  Future<Either<LensFailure, List<Lens>>> getByType(
    LensType lensType,
  );

  /// Lifecycle
  Future<Either<LensFailure, LensCreatedSuccess>> create(
    Lens lens,
  );

  Future<Either<LensFailure, LensUpdatedSuccess>> update(
    Lens lens,
  );

  Future<Either<LensFailure, LensDeletedSuccess>> delete(
    LensId id,
  );
}

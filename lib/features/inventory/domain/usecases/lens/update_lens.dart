import 'package:osm/core/either.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/failures/lens/lens_failure.dart';
import 'package:osm/features/inventory/domain/repositories/lens_repository.dart';
import 'package:osm/features/inventory/domain/success/lens/lens_success.dart';

class UpdateLens {
  final LensRepository repository;

  UpdateLens(this.repository);

  Future<Either<LensFailure, LensUpdatedSuccess>> call(
    Lens lens,
  ) async {
    if (lens.id!.value.isEmpty) {
      return const Left(
        LensValidationFailure('Lens ID is required'),
      );
    }

    if (lens.productName.trim().isEmpty) {
      return const Left(
        LensValidationFailure('Lens product name is required'),
      );
    }

    return repository.update(lens);
  }
}


import 'package:osm/core/either.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/failures/lens/lens_failure.dart';
import 'package:osm/features/inventory/domain/repositories/lens_repository.dart';
import 'package:osm/features/inventory/domain/success/lens/lens_success.dart';

class CreateLens {
  final LensRepository repository;

  CreateLens(this.repository);

  Future<Either<LensFailure, LensCreatedSuccess>> call(
    Lens lens,
  ) async {
    if (lens.productName.trim().isEmpty) {
      return const Left(
        LensValidationFailure('Lens product name is required'),
      );
    }

    if (lens.minIndex <= 0 || lens.maxIndex <= 0) {
      return const Left(
        LensValidationFailure('Invalid index range'),
      );
    }

    if (lens.minIndex > lens.maxIndex) {
      return const Left(
        LensValidationFailure('Min index cannot exceed max index'),
      );
    }

    if (lens.supportedMaterials.isEmpty) {
      return const Left(
        LensValidationFailure('At least one material must be supported'),
      );
    }

    return repository.create(lens);
  }
}

import 'package:osm/core/either.dart';
import 'package:osm/core/repositories/index_counter_repository.dart';
import 'package:osm/core/utils/counter_key.dart';
import 'package:osm/core/utils/sku_generator.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/failures/lens/lens_failure.dart';
import 'package:osm/features/inventory/domain/repositories/lens_repository.dart';
import 'package:osm/features/inventory/domain/success/lens/lens_success.dart';
import 'package:osm/features/inventory/presentation/dto/create_lens_input.dart';

class CreateLens {
  final LensRepository repository;
  final IndexCounterRepository counterRepository;

  CreateLens(this.repository, this.counterRepository);

  Future<Either<LensFailure, LensCreatedSuccess>> call(
    CreateLensInput input,
  ) async {
    if (input.productName.trim().isEmpty) {
      return const Left(LensValidationFailure('Lens product name is required'));
    }

    if (input.minIndex <= 0 || input.maxIndex <= 0) {
      return const Left(LensValidationFailure('Invalid index range'));
    }

    if (input.minIndex > input.maxIndex) {
      return const Left(
        LensValidationFailure('Min index cannot exceed max index'),
      );
    }

    if (input.supportedMaterials.isEmpty) {
      return const Left(
        LensValidationFailure('At least one material must be supported'),
      );
    }

    final counterKey = CounterKey.lens(
      company: input.companyName,
      lensType: input.lensType.name,
    );

    final seq = await counterRepository.next(counterKey);

    final sku = SkuGenerator.lensSku(
      company: input.companyName,
      lensType: input.lensType.name,
      minIndex: input.minIndex,
      maxIndex: input.maxIndex,
      sequence: seq,
    );

    final lens = Lens(
      qrKey: input.qrKey,
      createdAt: DateTime.now(),
      companyName: input.companyName,
      productName: input.productName,
      lensType: input.lensType,
      supportedMaterials: input.supportedMaterials,
      minIndex: input.minIndex,
      maxIndex: input.maxIndex,
      supportedCoatings: input.supportedCoatings,
      purchasePrice: input.purchasePrice,
      salesPrice: input.salesPrice,
      sku: sku,
      imageUrls: input.imageUrls,
      isActive: input.isActive,
    );

    return repository.create(lens);
  }
}

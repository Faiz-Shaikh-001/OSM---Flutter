import 'package:osm/core/either.dart';
import 'package:osm/core/repositories/index_counter_repository.dart';
import 'package:osm/core/utils/counter_key.dart';
import 'package:osm/core/utils/sku_generator.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame_variant.dart';
import 'package:osm/features/inventory/domain/failures/frames/frame_failure.dart';
import 'package:osm/features/inventory/domain/repositories/frame_repository.dart';
import 'package:osm/features/inventory/domain/success/frames/frame_success.dart';
import 'package:osm/features/inventory/presentation/dto/create_frame_input.dart';

class CreateFrame {
  final FrameRepository repository;
  final IndexCounterRepository counterRepository;

  CreateFrame(this.repository, this.counterRepository);

  Future<Either<FrameFailure, FrameCreatedSuccess>> call(
    CreateFrameInput input,
  ) async {
    if (input.name.isEmpty) {
      return const Left(FrameValidationFailure('Frame name is required'));
    }

    if (input.variants.isEmpty) {
      return const Left(
        FrameValidationFailure('At least one variant is required'),
      );
    }

    final List<FrameVariant> variants = [];

    for (final variantInput in input.variants) {
      final counterKey = CounterKey.frameVariant(
        company: input.companyName,
        type: input.type.name,
      );

      final seq = await counterRepository.next(counterKey);

      final variant = FrameVariant(
        sku: SkuGenerator.frameVariantSku(
          company: input.companyName,
          name: input.name,
          type: input.type.name,
          size: variantInput.size,
          color: variantInput.colorName,
          sequence: seq,
        ),
        productCode: variantInput.productCode,
        colorName: variantInput.colorName,
        colorValue: variantInput.colorValue,
        size: variantInput.size,
        quantity: variantInput.quantity,
        purchasePrice: variantInput.purchasePrice,
        salesPrice: variantInput.salesPrice,
        imageUrls: variantInput.imageUrls,
      );

      variants.add(variant);
    }

    final frame = Frame(
      qrKey: input.qrKey,
      createdAt: DateTime.now(),
      companyName: input.companyName,
      name: input.name,
      type: input.type,
      customTypeName: input.customTypeName,
      variants: variants,
    );  

    return repository.create(frame);
  }
}

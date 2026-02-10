import 'package:osm/core/either.dart';
import 'package:osm/core/repositories/index_counter_repository.dart';
import 'package:osm/core/utils/counter_key.dart';
import 'package:osm/core/utils/sku_generator.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame_variant.dart';
import 'package:osm/features/inventory/domain/failures/frames/frame_failure.dart';
import 'package:osm/features/inventory/domain/repositories/frame_repository.dart';
import 'package:osm/features/inventory/domain/success/frames/frame_success.dart';

class UpdateFrame {
  final FrameRepository repository;
  final IndexCounterRepository counterRepository;

  UpdateFrame(this.repository, this.counterRepository);

  Future<List<FrameVariant>> _processVariants(Frame frame) async {
    final List<FrameVariant> result = [];

    for (final variant in frame.variants) {
      if (variant.sku.isNotEmpty) {
        result.add(variant);
        continue;
      }

      final counterKey = CounterKey.frameVariant(
        company: frame.companyName,
        type: frame.type.name,
      );

      final seq = await counterRepository.next(counterKey);

      final sku = SkuGenerator.frameVariantSku(
        company: frame.companyName,
        name: frame.name,
        size: variant.size,
        type: frame.type.name,
        color: variant.colorName,
        sequence: seq,
      );

      result.add(
        FrameVariant(
          sku: sku,
          productCode: variant.productCode,
          colorName: variant.colorName,
          colorValue: variant.colorValue,
          size: variant.size,
          quantity: variant.quantity,
          purchasePrice: variant.purchasePrice,
          salesPrice: variant.salesPrice,
          imageUrls: variant.imageUrls,
        ),
      );
    }

    return result;
  }

  Future<Either<FrameFailure, FrameUpdatedSuccess>> call(Frame frame) async {
    if (frame.id == null) {
      return const Left(FrameValidationFailure('Frame ID is required'));
    }

    if (frame.name.trim().isEmpty) {
      return const Left(FrameValidationFailure('Frame name is required'));
    }

    final processedVariants = await _processVariants(frame);

    final updatedFrame = Frame(
      qrKey: frame.qrKey,
      id: frame.id,
      createdAt: frame.createdAt,
      companyName: frame.companyName,
      name: frame.name,
      type: frame.type,
      customTypeName: frame.customTypeName,
      variants: processedVariants,
    );

    return repository.update(updatedFrame);
  }
}

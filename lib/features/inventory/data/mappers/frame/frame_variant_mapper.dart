import 'package:osm/features/inventory/data/models/frame/frame_model.dart';
import 'package:osm/core/value_objects/money_mapper.dart';

import '../../../domain/entities/frame/frame_variant.dart';

class FrameVariantMapper {
  static FrameVariant toEntity(FrameVariantModel model) {
    if (model.code == null ||
        model.productCode == null ||
        model.colorName == null ||
        model.size == null) {
      throw StateError('Invalid FrameVariantModel: missing required fields');
    }

    return FrameVariant(
      code: model.code!,
      productCode: model.productCode!,
      colorName: model.colorName!,
      colorValue: model.colorValue,
      size: model.size!,
      quantity: model.quantity ?? 0,
      purchasePrice: MoneyMapper.fromPaise(model.purchasePrice ?? 0),
      salesPrice: MoneyMapper.fromPaise(model.salesPrice ?? 0),
      imageUrls: model.imageUrls ?? [],
    );
  }

  static FrameVariantModel toModel(FrameVariant entity) {
    return FrameVariantModel(
      code: entity.code,
      productCode: entity.productCode,
      colorName: entity.colorName,
      colorValue: entity.colorValue,
      size: entity.size,
      quantity: entity.quantity,
      purchasePrice: MoneyMapper.toPaise(entity.purchasePrice),
      salesPrice: MoneyMapper.toPaise(entity.salesPrice),
      imageUrls: entity.imageUrls,
    );
  }
}

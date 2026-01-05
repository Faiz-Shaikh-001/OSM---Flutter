import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/data/mappers/frame/frame_enum_mappers.dart';

import '../../../domain/entities/frame/frame.dart';

import '../../models/frame/frame_model.dart';
import 'frame_variant_mapper.dart';

class FrameMapper {
  static Frame toEntity(FrameModel model) {
    return Frame(
      qrKey: model.qrKey,
      id: FrameId(model.id.toString()),
      createdAt: model.createdAt,
      companyName: model.companyName,
      name: model.name,
      type: FrameEnumMapper.toEntity(model.frameType),
      customTypeName: model.customTypeName,
      variants: model.variants
          .map((variant) => FrameVariantMapper.toEntity(variant))
          .toList(),
    );
  }

  static FrameModel toModel(Frame entity) {
    final model = FrameModel(
      qrKey: entity.qrKey,
      createdAt: entity.createdAt,
      companyName: entity.companyName,
      name: entity.name,
      frameType: FrameEnumMapper.toModel(entity.type),
      customTypeName: entity.customTypeName,
      variants: entity.variants
          .map((variant) =>
              FrameVariantMapper.toModel(variant))
          .toList(),
    );

    if (entity.id != null) model.id = int.parse(entity.id!.value);

    return model;
  }
}

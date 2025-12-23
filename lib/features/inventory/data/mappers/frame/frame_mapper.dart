import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/data/mappers/frame/frame_enum_mappers.dart';

import '../../../domain/entities/frame/frame.dart';

import '../../models/frame/frame_model.dart';
import 'frame_variant_mapper.dart';

class FrameMapper {
  static Frame toEntity(FrameModel model) {
    return Frame(
      id: FrameId(model.id.toString()),
      createdAt: model.createdAt,
      companyName: model.companyName,
      name: model.name,
      type: FrameEnumMapper.toEntity(model.frameType),
      variants: model.variants
          .map((variant) => FrameVariantMapper.toEntity(variant))
          .toList(),
    );
  }

  static FrameModel toModel(Frame entity) {
    return FrameModel(
      createdAt: entity.createdAt,
      companyName: entity.companyName,
      name: entity.name,
      frameType: FrameEnumMapper.toModel(entity.type),
      variants: entity.variants
          .map((variant) =>
              FrameVariantMapper.toModel(variant))
          .toList(),
    );
  }
}

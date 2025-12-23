import 'package:osm/features/inventory/data/enums/frame_type_model.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame_type.dart';

class FrameEnumMapper {
  static FrameType toEntity(FrameTypeModel model) {
    switch (model) {
      case FrameTypeModel.rimless:
        return FrameType.rimless;
      case FrameTypeModel.halfRimless:
        return FrameType.halfRimless;
      case FrameTypeModel.fullMetal:
        return FrameType.fullMetal;
      case FrameTypeModel.fullShell:
        return FrameType.fullShell;
      case FrameTypeModel.goggles:
        return FrameType.goggles;
    }
  }

  static FrameTypeModel toModel(FrameType type) {
    switch (type) {
      case FrameType.rimless:
        return FrameTypeModel.rimless;
      case FrameType.halfRimless:
        return FrameTypeModel.halfRimless;
      case FrameType.fullMetal:
        return FrameTypeModel.fullMetal;
      case FrameType.fullShell:
        return FrameTypeModel.fullShell;
      case FrameType.goggles:
        return FrameTypeModel.goggles;
    }
  }
}

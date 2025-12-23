import 'package:osm/features/inventory/data/enums/lens_type_model.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens_type.dart';

class LensEnumMapper {
  static LensType toDomainLensType(LensTypeModel model) {
    switch (model) {
      case LensTypeModel.singleVision:
        return LensType.singleVision;
      case LensTypeModel.bifocal:
        return LensType.bifocal;
      case LensTypeModel.progressive:
        return LensType.progressive;
      case LensTypeModel.contactLens:
        return LensType.contactLens;
    }
  }

  static LensTypeModel toModelLensType(LensType model) {
    switch (model) {
      case LensType.singleVision:
        return LensTypeModel.singleVision;
      case LensType.bifocal:
        return LensTypeModel.bifocal;
      case LensType.progressive:
        return LensTypeModel.progressive;
      case LensType.contactLens:
        return LensTypeModel.contactLens;
    }
  }

  static LensMaterialType toDomainMaterial(
      LensMaterialTypeModel model) {
    switch (model) {
      case LensMaterialTypeModel.mineral:
        return LensMaterialType.mineral;
      case LensMaterialTypeModel.plastic:
        return LensMaterialType.plastic;
      case LensMaterialTypeModel.polycarbonate:
        return LensMaterialType.polycarbonate;
      case LensMaterialTypeModel.trivex:
        return LensMaterialType.trivex;
      case LensMaterialTypeModel.organic:
        return LensMaterialType.organic;
    }
  }

  static LensMaterialTypeModel toModelMaterial(
      LensMaterialType model) {
    switch (model) {
      case LensMaterialType.mineral:
        return LensMaterialTypeModel.mineral;
      case LensMaterialType.plastic:
        return LensMaterialTypeModel.plastic;
      case LensMaterialType.polycarbonate:
        return LensMaterialTypeModel.polycarbonate;
      case LensMaterialType.trivex:
        return LensMaterialTypeModel.trivex;
      case LensMaterialType.organic:
        return LensMaterialTypeModel.organic;
    }
  }

  static ProgressiveLensSide toDomainSide(
      ProgressiveLensSideModel model) {
    switch (model) {
      case ProgressiveLensSideModel.right:
        return ProgressiveLensSide.right;
      case ProgressiveLensSideModel.left:
        return ProgressiveLensSide.left;
    }
  }

  static ProgressiveLensSideModel toModelSide(
      ProgressiveLensSide model) {
    switch (model) {
      case ProgressiveLensSide.right:
        return ProgressiveLensSideModel.right;
      case ProgressiveLensSide.left:
        return ProgressiveLensSideModel.left;
    }
  }
}

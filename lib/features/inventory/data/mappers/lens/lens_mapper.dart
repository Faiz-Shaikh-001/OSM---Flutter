import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/data/mappers/lens/lens_enum_mappers.dart';
import 'package:osm/features/inventory/data/models/lens/lens_model.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';

class LensMapper {
  static Lens toEntity(LensModel model) {
    return Lens(
      id: LensId(model.id.toString()),
      createdAt: model.createdAt,
      companyName: model.companyName,
      productName: model.productName,
      lensType:
          LensEnumMapper.toDomainLensType(model.lensType),
      supportedMaterials: model.supportedMaterials
          .map(LensEnumMapper.toDomainMaterial)
          .toList(),
      minIndex: model.minIndex,
      maxIndex: model.maxIndex,
      supportedCoatings: model.supportedCoatings,
      imageUrls: model.imageUrls,
      isActive: model.isActive,
    );
  }

  static LensModel toModel(Lens entity) {
    return LensModel(
      createdAt: entity.createdAt,
      companyName: entity.companyName,
      productName: entity.productName,
      lensType:
          LensEnumMapper.toModelLensType(entity.lensType),
      supportedMaterials: entity.supportedMaterials
          .map(LensEnumMapper.toModelMaterial)
          .toList(),
      minIndex: entity.minIndex,
      maxIndex: entity.maxIndex,
      supportedCoatings: entity.supportedCoatings,
      imageUrls: entity.imageUrls,
      isActive: entity.isActive,
    );
  }
}

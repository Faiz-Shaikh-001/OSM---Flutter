import 'package:osm/core/value_objects/id.dart';
import 'package:osm/core/value_objects/money_mapper.dart';
import 'package:osm/features/inventory/data/mappers/lens/lens_enum_mappers.dart';
import 'package:osm/features/inventory/data/models/lens/lens_model.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';

class LensMapper {
  static Lens toEntity(LensModel model) {
    return Lens(
      qrKey: model.qrKey,
      id: LensId(model.id.toString()),
      createdAt: model.createdAt,
      companyName: model.companyName,
      productName: model.productName,
      productCode: model.productCode,
      lensType: LensEnumMapper.toDomainLensType(model.lensType),
      supportedMaterials: model.supportedMaterials
          .map(LensEnumMapper.toDomainMaterial)
          .toList(),
      minIndex: model.minIndex,
      maxIndex: model.maxIndex,
      supportedCoatings: model.supportedCoatings,
      imageUrls: model.imageUrls,
      isActive: model.isActive,
      purchasePrice: MoneyMapper.fromPaise(model.purchasePrice),
      salesPrice: MoneyMapper.fromPaise(model.salesPrice),
      sku: model.sku,
    );
  }

  static LensModel toModel(Lens entity) {
    final model = LensModel(
      qrKey: entity.qrKey,
      createdAt: entity.createdAt,
      companyName: entity.companyName,
      productName: entity.productName,
      productCode: entity.productCode,
      lensType: LensEnumMapper.toModelLensType(entity.lensType),
      supportedMaterials: entity.supportedMaterials
          .map(LensEnumMapper.toModelMaterial)
          .toList(),
      minIndex: entity.minIndex,
      maxIndex: entity.maxIndex,
      supportedCoatings: entity.supportedCoatings,
      imageUrls: entity.imageUrls,
      isActive: entity.isActive,
      purchasePrice: MoneyMapper.toPaise(entity.purchasePrice),
      salesPrice: MoneyMapper.toPaise(entity.salesPrice),
      sku: entity.sku,
    );

    if (entity.id != null) {
      model.id = int.parse(entity.id!.value);
    }
    return model;
  }
}

import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/data/models/accessory/accessory_model.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/core/value_objects/money_mapper.dart';

class AccessoryMapper {
  static Accessory toEntity(AccessoryModel model) {
    return Accessory(
      id: AccessoryId(model.id.toString()),
      createdAt: model.createdAt,
      category: model.category,
      brand: model.brand,
      name: model.name,
      sku: model.sku,
      quantity: model.quantity,
      purchasePrice: MoneyMapper.fromPaise(model.purchasePrice),
      salesPrice: MoneyMapper.fromPaise(model.salesPrice),
      imageUrls: model.imageUrls,
      isActive: model.isActive,
    );
  }

  static AccessoryModel toModel(Accessory entity) {
    return AccessoryModel(
      createdAt: entity.createdAt,
      category: entity.category,
      brand: entity.brand,
      name: entity.name,
      sku: entity.sku,
      quantity: entity.quantity,
      purchasePrice: MoneyMapper.toPaise(entity.purchasePrice),
      salesPrice: MoneyMapper.toPaise(entity.salesPrice),
      imageUrls: entity.imageUrls,
      isActive: entity.isActive,
    );
  }
}

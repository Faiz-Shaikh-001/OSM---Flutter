import 'package:osm/core/value_objects/money_mapper.dart';
import 'package:osm/features/inventory/data/mappers/lens/lens_enum_mappers.dart';
import 'package:osm/features/orders/data/mappers/order_item_type_mapper.dart';

import '../../domain/entities/order_item.dart';
import '../models/order_item/order_item_model.dart';

class OrderItemMapper {
   static OrderItem toEntity(OrderItemModel model) {
    return OrderItem(
      productID: model.id.toString(),
      productName: model.productName,
      productCode: model.productCode,
      type: OrderItemTypeMapper.toOrderItemType(model.itemType),
      quantity: model.quantity,
      unitPrice: MoneyMapper.fromPaise(model.unitPrice),

      // lens snapshot
      spherical: model.spherical,
      cylindrical: model.cylindrical,
      axis: model.axis,
      addPower: model.addPower,
      materialType: model.materialType != null
          ? LensEnumMapper.toDomainMaterial(model.materialType!)
          : null,
      refractiveIndex: model.refractiveIndex,
    );
  }

  static OrderItemModel toModel(OrderItem entity) {
    return OrderItemModel(
      productName: entity.productName,
      productCode: entity.productCode,
      itemType:
          OrderItemTypeMapper.toOrderItemTypeModel(entity.type),
      quantity: entity.quantity,
      unitPrice: MoneyMapper.toPaise(entity.unitPrice),

      spherical: entity.spherical,
      cylindrical: entity.cylindrical,
      axis: entity.axis,
      addPower: entity.addPower,
      materialType: entity.materialType != null
          ? LensEnumMapper.toModelMaterial(entity.materialType!)
          : null,
      refractiveIndex: entity.refractiveIndex,
    );
  }
}

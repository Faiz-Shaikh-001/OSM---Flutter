import 'package:flutter/cupertino.dart';
import 'package:osm/core/value_objects/money_mapper.dart';
import 'package:osm/features/inventory/data/mappers/lens/lens_enum_mappers.dart';
import 'package:osm/features/orders/data/mappers/order_item_type_mapper.dart';
import 'package:osm/features/prescription/domain/value_objects/eye_power.dart';
import 'package:osm/features/prescription/domain/value_objects/pupillary_distance.dart';

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
      rightEye: EyePower(
        sphere: model.rightSphere ?? 0.0,
        cylinder: model.rightCylinder,
        axis: model.rightAxis,
        add: model.rightAdd,
      ),
      leftEye: EyePower(
        sphere: model.leftSphere ?? 0.0,
        cylinder: model.leftCylinder,
        axis: model.leftAxis,
        add: model.leftAdd,
      ),
      pd: PupillaryDistance(
        left: model.pdLeft ?? 0.0,
        right: model.pdRight ?? 0.0,
      ),
      materialType: model.materialType != null
          ? LensEnumMapper.toDomainMaterial(model.materialType!)
          : null,
      coatings: model.coatings,
      basePrice: MoneyMapper.fromPaise(model.basePrice),
      materialSurcharge: (model.materialSurcharge / 100),
      coatingSurcharges: (model.coatingSurcharges / 100),
    );
  }

  static OrderItemModel toModel(OrderItem entity) {
    final model = OrderItemModel(
      productName: entity.productName,
      productCode: entity.productCode,
      itemType: OrderItemTypeMapper.toOrderItemTypeModel(entity.type),
      quantity: entity.quantity,
      unitPrice: MoneyMapper.toPaise(entity.unitPrice),
      materialType: entity.materialType != null
          ? LensEnumMapper.toModelMaterial(entity.materialType!)
          : null,
      coatings: entity.coatings,
      basePrice: MoneyMapper.toPaise(entity.basePrice),
      materialSurcharge: (entity.materialSurcharge * 100).round(),
      coatingSurcharges: (entity.coatingSurcharges * 100).round(),
    );

    debugPrint(entity.rightEye == null ? "Right EYE prescription not available" : "Right eye is available");
    debugPrint(entity.leftEye == null ? "Left EYE prescription not available" : "Left eye is available");

    if (entity.rightEye != null) {
      model.rightSphere = entity.rightEye!.sphere;
      model.rightCylinder = entity.rightEye!.cylinder;
      model.rightAxis = entity.rightEye!.axis;
      model.rightAdd = entity.rightEye!.add;
    }

    if (entity.leftEye != null) {
      model.leftSphere = entity.leftEye!.sphere;
      model.leftCylinder = entity.leftEye!.cylinder;
      model.leftAxis = entity.leftEye!.axis;
      model.leftAdd = entity.leftEye!.add;
    }

    if (entity.pd != null) {
      model.pdRight = entity.pd!.right;
      model.pdLeft = entity.pd!.left;
    }

    return model;
  }
}

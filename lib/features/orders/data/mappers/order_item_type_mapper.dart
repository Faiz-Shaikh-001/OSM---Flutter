import 'package:osm/features/orders/data/enums/order_item_type.dart';
import 'package:osm/features/orders/domain/entities/order_item_type.dart';

class OrderItemTypeMapper {
  static OrderItemTypeModel toOrderItemTypeModel(OrderItemType type) {
    switch (type) {
      case OrderItemType.frame:
        return OrderItemTypeModel.frame;
      case OrderItemType.lens:
        return OrderItemTypeModel.lens;
      case OrderItemType.accessory:
        return OrderItemTypeModel.accessory;
    }
  }

  static OrderItemType toOrderItemType(OrderItemTypeModel model) {
    switch (model) {
      case OrderItemTypeModel.frame:
        return OrderItemType.frame;
      case OrderItemTypeModel.lens:
        return OrderItemType.lens;
      case OrderItemTypeModel.accessory:
        return OrderItemType.accessory;
    }
  }
}

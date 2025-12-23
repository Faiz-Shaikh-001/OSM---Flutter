import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens_type.dart';

import 'order_item_type.dart';


class OrderItem {
  final String productName;
  final String productCode;
  final OrderItemType type;
  final int quantity;
  final Money unitPrice;

  final double? spherical;
  final double? cylindrical;
  final int? axis;
  final double? addPower;
  final LensMaterialType? materialType;
  final double? refractiveIndex;

  OrderItem({
    required this.productName,
    required this.productCode,
    required this.type,
    required this.quantity,
    required this.unitPrice,
    this.spherical,
    this.cylindrical,
    this.axis,
    this.addPower,
    this.materialType,
    this.refractiveIndex,
  });

  Money get total => Money(unitPrice.value * quantity);  
}

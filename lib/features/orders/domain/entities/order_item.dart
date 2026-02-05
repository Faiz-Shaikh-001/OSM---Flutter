import 'package:equatable/equatable.dart';
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens_type.dart';

import 'order_item_type.dart';

class OrderItem extends Equatable {
  final String productID;
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
    required this.productID,
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

  OrderItem copyWith({int? quantity, Money? unitPrice}) {
    return OrderItem(
      productID: productID,
      productName: productName,
      productCode: productCode,
      type: type,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      spherical: spherical,
      cylindrical: cylindrical,
      axis: axis,
      addPower: addPower,
      materialType: materialType,
      refractiveIndex: refractiveIndex,
    );
  }

  @override
  List<Object?> get props => [
    productID,
    productName,
    productCode,
    type,
    quantity,
    unitPrice,
    spherical,
    cylindrical,
    axis,
    addPower,
    materialType,
    refractiveIndex,
  ];
}

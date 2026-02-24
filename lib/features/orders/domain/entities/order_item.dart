import 'package:equatable/equatable.dart';
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens_type.dart';
import 'package:osm/features/prescription/domain/value_objects/eye_power.dart';
import 'package:osm/features/prescription/domain/value_objects/pupillary_distance.dart';

import 'order_item_type.dart';

class OrderItem extends Equatable {
  final String productID;
  final String productName;
  final String productCode;
  final OrderItemType type;
  final int quantity;
  final Money unitPrice;

  final EyePower? rightEye;
  final EyePower? leftEye;
  final PupillaryDistance? pd;

  final LensMaterialType? materialType;
  final List<String>? coatings;

  final Money basePrice;
  final double materialSurcharge;
  final double coatingSurcharges;

  const OrderItem({
    required this.productID,
    required this.productName,
    required this.productCode,
    required this.type,
    required this.quantity,
    required this.unitPrice,
    required this.basePrice,
    this.leftEye,
    this.rightEye,
    this.pd,
    this.materialType,
    this.coatings = const [],
    this.coatingSurcharges = 0.0,
    this.materialSurcharge = 0.0,
  });

  Money get total => Money(unitPrice.value * quantity);

  OrderItem copyWith({
    int? quantity,
    Money? unitPrice,
    EyePower? leftEye,
    EyePower? rightEye,
    PupillaryDistance? pd,
    LensMaterialType? materialType,
    List<String>? coatings,
    Money? basePrice,
    double? coatingSurcharges,
    double? materialSurcharge,
  }) {
    return OrderItem(
      productID: productID,
      productName: productName,
      productCode: productCode,
      type: type,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      leftEye: leftEye,
      rightEye: rightEye,
      pd: pd,
      materialType: materialType,
      coatings: coatings,
      basePrice: basePrice ?? Money(0),
      coatingSurcharges: coatingSurcharges ?? this.coatingSurcharges,
      materialSurcharge: materialSurcharge ?? this.materialSurcharge,
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
    leftEye,
    rightEye,
    pd,
    materialType,
    coatings,
    coatingSurcharges,
    materialSurcharge
  ];
}

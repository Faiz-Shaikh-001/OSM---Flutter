import 'package:isar/isar.dart';
import 'package:osm/features/inventory/data/enums/lens_type_model.dart';
import 'package:osm/features/orders/data/enums/order_item_type.dart';
import 'package:osm/features/orders/data/models/order/order_model.dart';

part 'order_item_model.g.dart';

@collection
class OrderItemModel {
  Id id = Isar.autoIncrement;

  final String productName;
  final String productCode;

  @Enumerated(EnumType.name)
  final OrderItemTypeModel itemType;

  final int quantity;

  final int unitPrice;

  final double? spherical;
  final double? cylindrical;
  final int? axis;
  final double? addPower;

  @Enumerated(EnumType.name)
  final LensMaterialTypeModel? materialType;

  final double? refractiveIndex;

  // ---- Relations ----
  final IsarLink<OrderModel> order;

  OrderItemModel({
    required this.productName,
    required this.productCode,
    required this.itemType,
    required this.quantity,
    required this.unitPrice,

    this.spherical,
    this.cylindrical,
    this.axis,
    this.addPower,
    this.materialType,
    this.refractiveIndex,

    IsarLink<OrderModel>? order,
  }) : order = order ?? IsarLink<OrderModel>();
}

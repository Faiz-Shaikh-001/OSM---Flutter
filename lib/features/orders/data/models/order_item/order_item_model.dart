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

  late double? rightSphere;
  double? rightCylinder;
  int? rightAxis;
  double? rightAdd;

  late double? leftSphere;
  double? leftCylinder;
  int? leftAxis;
  double? leftAdd;

  // Pupillary distance
  double? pdRight;
  double? pdLeft;

  @Enumerated(EnumType.name)
  final LensMaterialTypeModel? materialType;

  final List<String>? coatings;

  final int basePrice;
  final int materialSurcharge;
  final int coatingSurcharges;

  // ---- Relations ----
  final IsarLink<OrderModel> order;

  OrderItemModel({
    required this.productName,
    required this.productCode,
    required this.itemType,
    required this.quantity,
    required this.unitPrice,

    this.rightAdd,
    this.rightAxis,
    this.rightCylinder,
    this.rightSphere,
    this.pdRight,
    this.leftAdd,
    this.leftAxis,
    this.leftCylinder,
    this.leftSphere,
    this.pdLeft,
    this.materialType,
    required this.basePrice,
    this.materialSurcharge = 0,
    this.coatingSurcharges = 0,
    this.coatings = const [],
    IsarLink<OrderModel>? order,
  }) : order = order ?? IsarLink<OrderModel>();
}

import 'package:isar/isar.dart';
import 'package:osm/data/models/frame_model.dart';
import 'package:osm/data/models/lens_model.dart';
import 'package:osm/data/models/order_model.dart';

part 'order_item_model.g.dart';

@collection
class OrderItemModel {
  Id id = Isar.autoIncrement;

  final String productName;
  final int quantity;
  final double unitPrice;

  // ---- RelationShips ----
  final order = IsarLink<OrderModel>();
  final frame = IsarLink<FrameModel>();
  final lens = IsarLink<LensModel>();

  OrderItemModel({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });

  OrderItemModel copyWith({
    Id? id,
    String? productName,
    int? quantity,
    double? unitPrice,
  }) {
    return OrderItemModel(
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    )..id = id ?? this.id;
  }
}

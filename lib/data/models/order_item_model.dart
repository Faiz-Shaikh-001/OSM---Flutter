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
  final IsarLink<OrderModel> order; // Initialized in constructor
  final IsarLink<FrameModel> frame; // Initialized in constructor
  final IsarLink<LensModel> lens; // Initialized in constructor

  OrderItemModel({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    IsarLink<OrderModel>? order, // Add to constructor
    IsarLink<FrameModel>? frame, // Add to constructor
    IsarLink<LensModel>? lens, // Add to constructor
  }) : order = order ?? IsarLink<OrderModel>(),
       frame = frame ?? IsarLink<FrameModel>(),
       lens = lens ?? IsarLink<LensModel>();

  OrderItemModel copyWith({
    Id? id,
    String? productName,
    int? quantity,
    double? unitPrice,
    IsarLink<OrderModel>? order,
    IsarLink<FrameModel>? frame,
    IsarLink<LensModel>? lens,
  }) {
    return OrderItemModel(
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      order: order ?? this.order,
      frame: frame ?? this.frame,
      lens: lens ?? this.lens,
    )..id = id ?? this.id;
  }
}

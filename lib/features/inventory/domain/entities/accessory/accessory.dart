import 'package:osm/core/value_objects/id.dart';
import 'package:osm/core/value_objects/money.dart';

class Accessory {
  final AccessoryId? id;
  final DateTime createdAt;
  final String category;
  final String brand;
  final String name;
  final String sku;
  final String? description;
  final int quantity;
  final Money purchasePrice;
  final Money salesPrice;
  final List<String> imageUrls;
  final bool isActive;
  final String qrKey;

  Accessory({
    required this.qrKey,
    this.id,
    required this.createdAt,
    required this.category,
    required this.brand,
    required this.name,
    required this.sku,
    this.description,
    required this.quantity,
    required this.purchasePrice,
    required this.salesPrice,
    required this.imageUrls,
    required this.isActive,
  });
}

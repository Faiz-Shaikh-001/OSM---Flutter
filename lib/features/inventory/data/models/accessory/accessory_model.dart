import 'package:isar/isar.dart';

part 'accessory_model.g.dart';

@collection
class AccessoryModel {
  Id id = Isar.autoIncrement;

  final DateTime createdAt;

  @Index(type: IndexType.hash)
  final String category;

  @Index(type: IndexType.hash)
  final String brand;

  @Index(type: IndexType.value)
  final String name;

  @Index(type: IndexType.hash)
  final String sku;

  final String? description;

  final int quantity;

  final int purchasePrice;
  final int salesPrice;

  final List<String> imageUrls;

  final bool isActive;

  @Index(type: IndexType.hash, unique: true)
  final String qrKey;

  AccessoryModel({
    required this.qrKey,
    required this.createdAt,
    required this.category,
    required this.brand,
    required this.name,
    required this.sku,
    this.description,
    this.quantity = 0,
    this.purchasePrice = 0,
    this.salesPrice = 0,
    this.imageUrls = const [],
    this.isActive = true,
  });
}

import 'package:osm/core/value_objects/money.dart';

class CreateAccessoryInput {
  final String category;
  final String brand;
  final String name;
  final String? description;
  final int quantity;
  final Money purchasePrice;
  final Money salesPrice;
  final List<String> imageUrls;
  final bool isActive;
  final String qrKey;
  
  CreateAccessoryInput({
    required this.category,
    required this.brand,
    required this.imageUrls,  
    required this.isActive,
    required this.purchasePrice,
    required this.quantity,
    required this.salesPrice,
    required this.name,
    this.description,
    required this.qrKey,
  });
}
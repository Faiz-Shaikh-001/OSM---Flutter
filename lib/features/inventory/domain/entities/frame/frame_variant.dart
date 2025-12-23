import 'package:osm/core/value_objects/money.dart';

class FrameVariant {
  final String code;
  final String productCode;
  final String colorName;
  final int? colorValue;
  final int size;
  final int quantity;
  final Money purchasePrice;
  final Money salesPrice;
  final List<String> imageUrls;

  FrameVariant({
    required this.code,
    required this.productCode,
    required this.colorName,
    this.colorValue,
    required this.size,
    required this.quantity,
    required this.purchasePrice,
    required this.salesPrice,
    required this.imageUrls,
  });
}

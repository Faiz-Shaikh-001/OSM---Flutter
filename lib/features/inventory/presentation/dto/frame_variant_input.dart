import 'package:osm/core/value_objects/money.dart';

class FrameVariantInput {
  final String productCode;
  final String colorName;
  final int? colorValue;
  final String size;
  final int quantity;
  final Money purchasePrice;
  final Money salesPrice;
  final List<String> imageUrls;

  FrameVariantInput({
    required this.productCode,
    required this.colorName,
    required this.colorValue,
    required this.size,
    required this.quantity,
    required this.purchasePrice,
    required this.salesPrice,
    required this.imageUrls,
  });
}

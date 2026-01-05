import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens_type.dart';

class CreateLensInput {
  final String companyName;
  final String productName;
  final LensType lensType;
  final List<LensMaterialType> supportedMaterials;
  final double minIndex;
  final double maxIndex;
  final List<String> supportedCoatings;
  final Money purchasePrice;
  final Money salesPrice;
  final List<String> imageUrls;
  final String productCode;
  final bool isActive;
  final String qrKey;

  CreateLensInput({
    required this.qrKey,
    required this.companyName,
    required this.imageUrls,
    required this.lensType,
    required this.maxIndex,
    required this.minIndex,
    required this.productCode,
    required this.productName,
    required this.purchasePrice,
    required this.salesPrice,
    required this.supportedCoatings,
    required this.supportedMaterials,
    required this.isActive,
  });
}
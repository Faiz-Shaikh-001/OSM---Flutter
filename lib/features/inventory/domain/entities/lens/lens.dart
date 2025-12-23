import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens_type.dart';

class Lens {
  final LensId id;
  final DateTime createdAt;
  final String companyName;
  final String productName;
  final LensType lensType;
  final List<LensMaterialType> supportedMaterials;
  final double minIndex;
  final double maxIndex;
  final List<String> supportedCoatings;
  final List<String> imageUrls;
  final bool isActive;

  Lens({
    required this.id,
    required this.createdAt,
    required this.companyName,
    required this.productName,
    required this.lensType,
    required this.supportedMaterials,
    required this.minIndex,
    required this.maxIndex,
    required this.supportedCoatings,
    required this.imageUrls,
    required this.isActive,
  });
}

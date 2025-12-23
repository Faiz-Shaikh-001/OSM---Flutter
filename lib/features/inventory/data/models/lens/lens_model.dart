import 'package:isar/isar.dart';
import 'package:osm/features/inventory/data/enums/lens_type_model.dart';

part 'lens_model.g.dart';

@collection
class LensModel {
  Id id = Isar.autoIncrement;

  final DateTime createdAt;

  @Index(type: IndexType.hash)
  final String companyName;

  @Index(type: IndexType.value)
  final String productName;

  @Enumerated(EnumType.name)
  final LensTypeModel lensType;

  @Enumerated(EnumType.name)
  final List<LensMaterialTypeModel> supportedMaterials;

  final double minIndex;
  final double maxIndex;
  final List<String> supportedCoatings;
  final List<String> imageUrls;
  final bool isActive;

  LensModel({
    required this.createdAt,
    required this.companyName,
    required this.productName, 
    required this.lensType,
    required this.supportedMaterials,
    required this.minIndex,
    required this.maxIndex,
    this.supportedCoatings = const [],
    this.imageUrls = const [],
    this.isActive = true,
  });
}

import 'package:isar/isar.dart';
import 'package:osm/features/inventory/data/enums/frame_type_model.dart';

part 'frame_model.g.dart';

@collection
class FrameModel {
  Id id = Isar.autoIncrement;

  final DateTime createdAt;

  @Enumerated(EnumType.name)
  final FrameTypeModel frameType;

  @Index(type: IndexType.hash)
  final String companyName;

  @Index(type: IndexType.value)
  final String name;

  final List<FrameVariantModel> variants;

  FrameModel({
    required this.createdAt,
    required this.frameType,
    required this.companyName,
    required this.name,
    this.variants = const [],
  });
}

@embedded
class FrameVariantModel {
  final String? code;

  final String? productCode;

  final String? colorName;
  final int? colorValue;
  final int? size;

  final int? quantity;

  final int? purchasePrice;
  final int? salesPrice;

  final List<String>? imageUrls;
  final List<String>? localImagePaths;

  FrameVariantModel({
    this.code,
    this.productCode,
    this.colorName,
    this.colorValue,
    this.size,
    this.quantity,
    this.purchasePrice,
    this.salesPrice,
    this.imageUrls = const [],
    this.localImagePaths = const [],
  });
}
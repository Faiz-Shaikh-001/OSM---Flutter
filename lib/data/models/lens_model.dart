import 'dart:io';
import 'package:osm/data/models/inventory_model.dart';

import 'lens_enums.dart';
import 'package:isar/isar.dart';

part 'lens_model.g.dart';

String _shorten(String value) {
  return value.length > 5
      ? value.substring(0, 5).toUpperCase()
      : value.toUpperCase();
}

@collection
class LensModel {
  Id id = Isar.autoIncrement;
  final DateTime? date;
  @Index(type: IndexType.hash)
  final String companyName;
  @Index(type: IndexType.value)
  final String productName;
  @Enumerated(EnumType.name)
  final LensType lensType;
  final List<LensVariant> variants;

  // --- Relationships ---
  @Backlink(to: 'lens')
  final inventoryEntry = IsarLinks<InventoryModel>();

  LensModel._internal({
    required this.date,
    required this.companyName,
    required this.productName,
    required this.lensType,
    this.variants = const [],
  });

  factory LensModel({
    DateTime? date, // Optional, nullable parameter for convenience
    required String companyName,
    required String productName,
    required LensType lensType,
    List<LensVariant> variants = const [],
  }) {
    return LensModel._internal(
      date: date ?? DateTime.now(), // Logic for default non-constant value
      companyName: companyName,
      productName: productName,
      lensType: lensType,
      variants: variants,
    );
  }

  LensModel copyWith({
    Id? id,
    DateTime? date,
    LensType? lensType,
    String? companyName,
    String? productName,
    List<LensVariant>? variants,
  }) {
    return LensModel(
      date: date ?? this.date,
      companyName: companyName ?? this.companyName,
      productName: productName ?? this.productName,
      lensType: lensType ?? this.lensType,
      variants: variants ?? this.variants,
    )..id = id ?? this.id;
  }

  String get modelProductCode {
    String typePrefix;
    switch (lensType) {
      case LensType.singleVision:
        typePrefix = 'SV';
        break;
      case LensType.bifocal:
        typePrefix = 'BF';
        break;
      case LensType.progressive:
        typePrefix = 'PG';
        break;
      case LensType.contactLens:
        typePrefix = 'CL';
        break;
    }
    return 'LENS-$typePrefix-${_shorten(productName)}-${_shorten(companyName)}';
  }
}

@embedded
class LensVariant {
  final double? spherical;
  final double? cylindrical;
  final int? pair;
  final int? diameter;
  final double? purchasePrice;
  final double? salesPrice;
  @Enumerated(EnumType.name)
  final LensMaterialType? materialType;
  final int? index;
  final int? axis;
  final double? add;
  final int? baseCurve;
  @Enumerated(EnumType.name)
  final ProgressiveLensSide? side;

  final int? quantity;
  final List<String>? imageUrls;
  final List<String>? localImagesPaths;
  final String? productCode;

  LensVariant({
    this.spherical,
    this.cylindrical,
    this.pair,
    this.diameter,
    this.purchasePrice,
    this.salesPrice,
    this.materialType,
    this.index,
    this.axis,
    this.add,
    this.baseCurve,
    this.side,
    this.quantity = 0,
    this.imageUrls = const [],
    this.localImagesPaths = const [],
    this.productCode,
  });

  // Generates a unique product code for the specific lens variant
  // This combines the model's product code with variant-specific details.
  static String generateProductCode(
    String companyName,
    String productName,
    LensType lensType,
    double spherical,
    double cylindrical,
    int diameter,
    LensMaterialType? materialType,
    int? index,
    int? axis,
    double? add,
    int? baseCurve,
    ProgressiveLensSide? side,
  ) {
    String typePrefix;
    switch (lensType) {
      case LensType.singleVision:
        typePrefix = 'SV';
        break;
      case LensType.bifocal:
        typePrefix = 'BF';
        break;
      case LensType.progressive:
        typePrefix = 'PG';
        break;
      case LensType.contactLens:
        typePrefix = 'CL';
        break;
    }
    final String modelCodePart =
        'Lens-$typePrefix-${_shorten(productName)}-${_shorten(companyName)}';

    String variantSpecificCode =
        '${spherical}_${cylindrical}_${diameter}_${materialType?.displayName ?? ''}_${index ?? ''}_${axis ?? ''}_${add ?? ''}_${baseCurve ?? ''}_${side?.displayName ?? ''}';

    variantSpecificCode = variantSpecificCode
        .replaceAll(RegExp(r'_{2,}'), '_')
        .replaceAll(RegExp(r'_$|^_'), '');

    return '$modelCodePart-${variantSpecificCode.isEmpty ? 'STD' : variantSpecificCode.toUpperCase()}';
  }

  LensVariant copyWith({
    double? spherical,
    double? cylindrical,
    int? pair,
    int? diameter,
    double? purchasePrice,
    double? salesPrice,
    LensMaterialType? materialType,
    int? index,
    int? axis,
    double? add,
    int? baseCurve,
    ProgressiveLensSide? side,
    int? quantity,
    List<String>? imageUrls,
    List<String>? localImagesPaths,
    String? productCode,
  }) {
    return LensVariant(
      spherical: spherical ?? this.spherical,
      cylindrical: cylindrical ?? this.cylindrical,
      pair: pair ?? this.pair,
      diameter: diameter ?? this.diameter,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      salesPrice: salesPrice ?? this.salesPrice,
      materialType: materialType ?? this.materialType,
      index: index ?? this.index,
      axis: axis ?? this.axis,
      add: add ?? this.add,
      baseCurve: baseCurve ?? this.baseCurve,
      side: side ?? this.side,
      quantity: quantity ?? this.quantity,
      imageUrls: imageUrls ?? this.imageUrls,
      localImagesPaths: localImagesPaths ?? this.localImagesPaths,
      productCode: productCode ?? this.productCode,
    );
  }
}

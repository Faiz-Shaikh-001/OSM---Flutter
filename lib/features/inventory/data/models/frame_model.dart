// imports
import 'package:flutter/material.dart'; // Keep if you use Color, otherwise remove
import 'package:isar/isar.dart';
import 'package:osm/features/inventory/data/models/inventory_model.dart';
import 'frame_enums.dart';

part 'frame_model.g.dart';

String _shorten(String value) {
  return value.length > 5
      ? value.substring(0, 5).toUpperCase()
      : value.toUpperCase();
}

// Frame Model
@collection
class FrameModel {
  Id id = Isar.autoIncrement;
  final DateTime? date;

  @Enumerated(EnumType.name)
  final FrameType frameType;

  @Index(type: IndexType.hash)
  final String companyName;

  @Index(type: IndexType.value)
  final String name;

  final List<FrameVariant> variants;

  // --- Relationships ---
  @Backlink(to: 'frame')
  final IsarLink<InventoryModel> inventoryEntry; // Initialized in constructor

  FrameModel._internal({
    required this.date,
    required this.companyName,
    required this.frameType,
    required this.name,
    this.variants = const [],
    IsarLink<InventoryModel>? inventoryEntry, // Add to constructor
  }) : inventoryEntry =
           inventoryEntry ?? IsarLink<InventoryModel>(); // Initialize here

  factory FrameModel({
    DateTime? date, // Optional, nullable parameter
    required String companyName,
    required FrameType frameType,
    required String name,
    List<FrameVariant> variants = const [],
  }) {
    return FrameModel._internal(
      date: date ?? DateTime.now(), // Logic for default non-constant value
      companyName: companyName,
      frameType: frameType,
      name: name,
      variants: variants,
      inventoryEntry: IsarLink<InventoryModel>(), // Pass new instance
    );
  }

  // Frame copywith function to create a duplicate instead of changing the original values
  FrameModel copyWith({
    Id? id,
    DateTime? date,
    FrameType? frameType,
    String? companyName,
    String? name,
    List<FrameVariant>? variants,
    IsarLink<InventoryModel>? inventoryEntry,
  }) {
    return FrameModel._internal(
      // Call internal constructor
      date: date ?? this.date,
      frameType: frameType ?? this.frameType,
      companyName: companyName ?? this.companyName,
      name: name ?? this.name,
      variants: variants ?? this.variants,
      inventoryEntry: inventoryEntry ?? this.inventoryEntry,
    )..id = id ?? this.id;
  }

  String get modelProductCode =>
      'Frame-${_shorten(name)}-${_shorten(companyName)}';
}

// Frame variant
@embedded
class FrameVariant {
  final List<String> imageUrls;
  final List<String> localImagesPaths;
  final String? code;
  final int? colorValue;
  final String? colorName;
  final int? size;
  final int? quantity;
  final double? salesPrice;
  final double? purchasePrice;
  final String? productCode;

  FrameVariant({
    this.imageUrls = const [],
    this.localImagesPaths = const [],
    this.code,
    Color? color,
    this.colorName,
    this.productCode,
    this.size,
    this.quantity = 0,
    this.purchasePrice = 0,
    this.salesPrice = 0,
  }) : colorValue = color?.value;

  @ignore
  Color? get color => colorValue != null ? Color(colorValue!) : null;

  static String generateProductCode(
    FrameType frameType,
    String companyName,
    String productName,
    String variantCode,
    String colorName,
    int size,
  ) {
    final frameTypeCode = FrameTypeHelper.getFrameTypeCode(frameType);

    final String abbreviation = RegExp(
      r'[A-Z]',
    ).allMatches(colorName).map((match) => match.group(0)).join();

    final String modelAbbreviation = _shorten(productName);
    final String companyAbbreviation = _shorten(companyName);

    return "FRAME-$frameTypeCode-$variantCode-$size-$abbreviation-$modelAbbreviation-$companyAbbreviation";
  }

  // Frame copywith function to create a duplicate copy instead of directly changing the original
  FrameVariant copyWith({
    List<String>? imageUrls,
    List<String>?
    localImagesPaths, // Changed from File to String for Isar compatibility
    String? code,
    Color? color,
    String? colorName,
    int? size,
    int? quantity,
    String? productCode,
    double? salesPrice,
    double? purchasePrice,
  }) {
    return FrameVariant(
      imageUrls: imageUrls ?? this.imageUrls,
      localImagesPaths:
          localImagesPaths ?? this.localImagesPaths, // Corrected access
      code: code ?? this.code,
      color: color ?? this.color,
      colorName: colorName ?? this.colorName,
      size: size ?? this.size,
      productCode: productCode ?? this.productCode,
      quantity: quantity ?? this.quantity,
      salesPrice: salesPrice ?? this.salesPrice,
      purchasePrice: purchasePrice ?? this.purchasePrice,
    );
  }
}

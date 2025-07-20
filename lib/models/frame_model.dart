// imports
import 'dart:convert';
import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Frame Model
class FrameModel {
  final String id;
  final DateTime date;
  final FrameType frameType;
  final String companyName;
  final String name;
  final List<FrameVariant> variants;

  FrameModel({
    String? id,
    DateTime? date,
    required this.companyName,
    required this.frameType,
    required this.name,
    this.variants = const [],
  }) : id = id ?? const Uuid().v4(),
       date = date ?? DateTime.now();

  // factory constructor used to convert fetched data from storage/db to model
  factory FrameModel.fromJson(Map<String, dynamic> json) {
    return FrameModel(
      id: json['id'],
      companyName: json['companyName'],
      frameType:
          FrameTypeExtension.fromString(json['frameType']) ?? FrameType.rimless,
      name: json['name'],
      date: DateTime.parse(json['date']),
    );
  }

  // to json method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'companyName': companyName,
      'frameType': frameType.displayName,
      'name': name,
    };
  }

  // Frame copywith function to create a duplicate instead of changing the original values
  FrameModel copyWith({
    String? id,
    DateTime? date,
    FrameType? frameType,
    String? companyName,
    String? name,
    List<FrameVariant>? variants,
  }) {
    return FrameModel(
      id: id ?? this.id,
      date: date ?? this.date,
      frameType: frameType ?? this.frameType,
      companyName: companyName ?? this.companyName,
      name: name ?? this.name,
      variants: variants ?? this.variants,
    );
  }
}

// Frame variant
class FrameVariant {
  final List<String> imageUrls;
  final List<File> localImages;
  final FrameModel frame;
  final String code;
  final Color color;
  final String colorName;
  final int size;
  final int quantity;
  final double salesPrice;
  final double purchasePrice;
  final String productCode;

  FrameVariant({
    this.imageUrls = const [],
    this.localImages = const [],
    required this.frame,
    required this.code,
    required this.color,
    required this.colorName,
    required this.productCode,
    required this.size,
    this.quantity = 0,
    this.purchasePrice = 0,
    this.salesPrice = 0,
  });

  // factory constructor
  factory FrameVariant.fromJson(Map<String, dynamic> json) {
    return FrameVariant(
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      frame: FrameModel.fromJson(json['frame']),
      code: json['code'],
      color: Color(int.parse(json['color'])),
      colorName: json['colorName'],
      size: json['size'],
      quantity: json['quantity'],
      productCode: json['productCode'],
      purchasePrice: json['purchasePrice'].toDouble(),
      salesPrice: json['salesPrice'].toDouble(),
    );
  }

  // to json method
  Map<String, dynamic> toJson() {
    return {
      'imageUrls': imageUrls,
      'frame': frame.toJson(),
      'code': code,
      'color': color.value.toString(),
      'colorName': colorName,
      'size': size,
      'productCode': productCode,
      'quantity': quantity,
      'purchasePrice': purchasePrice,
      'salesPrice': salesPrice,
    };
  }

  // Frame copywith function to create a duplicate copy instead of directly changing the original
  FrameVariant copyWith({
    List<String>? imageUrls,
    List<File>? localImages,
    FrameModel? frame,
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
      localImages: localImages ?? this.localImages,
      frame: frame ?? this.frame,
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

// options for frame types
enum FrameType { rimless, halfRimless, fullMetal, fullShell, goggles }

extension FrameTypeExtension on FrameType {
  String get displayName {
    switch (this) {
      case FrameType.rimless:
        return '3 Piece / Rimless';
      case FrameType.halfRimless:
        return 'Half Rimless / Supra';
      case FrameType.fullMetal:
        return 'Full Metal';
      case FrameType.fullShell:
        return 'Full Shell / Plastic';
      case FrameType.goggles:
        return 'Goggles';
    }
  }

  static FrameType? fromString(String value) {
    return FrameType.values.firstWhere(
      (e) => e.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => FrameType.rimless,
    );
  }
}

class FrameTypeHelper {
  static Map<FrameType, int> frameTypeCodes = {
    FrameType.rimless: 1,
    FrameType.halfRimless: 2,
    FrameType.fullMetal: 3,
    FrameType.fullShell: 4,
    FrameType.goggles: 5,
  };

  static int getFrameTypeCode(FrameType type) {
    return frameTypeCodes[type] ?? 0;
  }
}

// Get product code function to get the sku code
extension FrameVariantExtension on FrameVariant {
  String getProductCode(FrameType frameType) {
    final frameCode = FrameTypeHelper.getFrameTypeCode(frameType);

    final String abbreviation = RegExp(
      r'[A-Z]',
    ).allMatches(colorName).map((match) => match.group(0)).join();

    return "FRAME-$frameCode-$code-$size-$abbreviation";
  }
}

// Color name cache
class ColorNameCache {
  static final Map<String, String> _cache = {};

  static String? get(String hex) => _cache[hex];

  static void set(String hex, String name) {
    _cache[hex] = name;
  }
}

class FrameFactory {
  static Future<FrameVariant> createVariantWithColorName({
    required FrameModel frame,
    required String code,
    required Color color,
    required int size,
    required int quantity,
    required double purchasePrice,
    required double salesPrice,
  }) async {
    final hex = color.value
        .toRadixString(16)
        .padLeft(8, '0')
        .substring(2)
        .toUpperCase();

    // Check local cache first
    String? colorName = ColorNameCache.get(hex);

    if (colorName == null) {
      try {
        final response = await http
            .get(Uri.parse('https://www.thecolorapi.com/id?hex=$hex'))
            .timeout(const Duration(seconds: 3));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final fetchedName = data['name']?['value'];
          if (fetchedName is String && fetchedName.isNotEmpty) {
            colorName = fetchedName;
          }
        } else {
          colorName = '#$hex'; // fallback if response fails
        }
      } catch (e) {
        colorName = '#$hex'; // fallback on exception/timeout
      }

      ColorNameCache.set(hex, colorName ?? '#$hex');
    }

    final temp = FrameVariant(
      frame: frame,
      code: code,
      color: color,
      colorName: colorName!,
      quantity: quantity,
      purchasePrice: purchasePrice,
      salesPrice: salesPrice,
      productCode: '',
      size: size,
    );

    final productCode = temp.getProductCode(frame.frameType);

    return temp.copyWith(productCode: productCode);
  }
}

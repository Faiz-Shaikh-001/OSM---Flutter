import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class Frame {
  final DateTime date;
  final FrameType frameType;
  final String name;
  final String code;
  final Color color;
  final String colorName;
  final int size;
  final int quantity;
  final double purchasePrice;
  final double salesPrice;

  Frame({
    DateTime? date,
    required this.frameType,
    required this.name,
    required this.code,
    required this.color,
    required this.colorName,
    required this.size,
    this.quantity = 0,
    this.purchasePrice = 0,
    this.salesPrice = 0,
  }) : date = date ?? DateTime.now();

  factory Frame.fromJson(Map<String, dynamic> json) {
    return Frame(
      date: DateTime.parse(json['date']),
      frameType:
          FrameTypeExtension.fromString(json['type']) ?? FrameType.rimless,
      name: json['name'],
      code: json['code'],
      color: Color(int.parse(json['color'])),
      colorName: json['colorName'],
      size: json['size'],
      quantity: json['quantity'],
      purchasePrice: json['purchasePrice'].toDouble(),
      salesPrice: json['salesPrice'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'type': frameType.displayName,
      'name': name,
      'code': code,
      'color': color,
      'colorName': colorName,
      'size': size,
      'quantity': quantity,
      'purchasePrice': purchasePrice,
      'salesPrice': salesPrice,
    };
  }

  Frame copyWith({
    DateTime? date,
    FrameType? frameType,
    String? name,
    String? code,
    Color? color,
    String? colorName,
    int? size,
    int? quantity,
    double? purchasePrice,
    double? salesPrice,
  }) {
    return Frame(
      date: date ?? this.date,
      frameType: frameType ?? this.frameType,
      name: name ?? this.name,
      code: code ?? this.code,
      color: color ?? this.color,
      colorName: colorName ?? this.colorName,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      salesPrice: salesPrice ?? this.salesPrice,
    );
  }

  String getProductCode() {
    final frameCode = FrameTypeHelper.getFrameTypeCode(frameType);

    final String abbrevation = RegExp(
      r'[A-Z]',
    ).allMatches(colorName).map((match) => match.group(0)).join();

    return "FRAME-$frameCode-$code-$size-$abbrevation";
  }

  static Future<Frame> createWithColorName({
    required FrameType frameType,
    required String name,
    required String code,
    required Color color,
    required int size,
    required int quantity,
    required double purchasePrice,
    required double salesPrice,
    DateTime? date,
  }) async {
    final colorHex = color.value.toRadixString(16).padLeft(8, '0').substring(2);
    final response = await http.get(
      Uri.parse('https://www.thecolorapi.com/id?hex=$colorHex'),
    );

    String colorName = '#${colorHex.toUpperCase()}';
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      colorName = data['name']['value'] ?? colorName;
    }

    return Frame(
      date: date,
      frameType: frameType,
      name: name,
      code: code,
      color: color,
      colorName: colorName,
      size: size,
      quantity: quantity,
      purchasePrice: purchasePrice,
      salesPrice: salesPrice,
    );
  }
}

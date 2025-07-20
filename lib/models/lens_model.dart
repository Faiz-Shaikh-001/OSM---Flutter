import 'package:flutter/material.dart';

enum LensMaterialType { mineral, plastic, polycarbonate, trivex, organic }

extension LensMaterialTypeExtension on LensMaterialType {
  String get displayName {
    switch (this) {
      case LensMaterialType.mineral:
        return "Mineral Lens";
      case LensMaterialType.plastic:
        return "Plastic Lens";
      case LensMaterialType.polycarbonate:
        return "Polycarbonate Lens";
      case LensMaterialType.trivex:
        return "Trivex Lens";
      case LensMaterialType.organic:
        return "Organic Lens";
    }
  }

  static LensMaterialType? fromString(String value) {
    return LensMaterialType.values.firstWhere(
      (e) => e.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => LensMaterialType.mineral,
    );
  }
}

enum ProgressiveLensSide { right, left }

extension ProgressiveLensSideExtension on ProgressiveLensSide {
  String get displayName {
    switch (this) {
      case ProgressiveLensSide.right:
        return "Right";
      case ProgressiveLensSide.left:
        return "Left";
    }
  }

  static ProgressiveLensSide? fromString(String value) {
    return ProgressiveLensSide.values.firstWhere(
      (e) => e.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => ProgressiveLensSide.left,
    );
  }
}

abstract class BaseLens {
  final String companyName;
  final String name;
  final double spherical;
  final double cylindrical;
  final int pair;
  final int diameter;
  final double purchasePrice;
  final double salesPrice;

  BaseLens({
    required this.companyName,
    required this.name,
    required this.spherical,
    required this.cylindrical,
    required this.pair,
    required this.diameter,
    required this.purchasePrice,
    required this.salesPrice,
  });

  String get productCode => 'Unknown';

  String _shorten(String value) {
    return value.length > 5
        ? value.substring(0, 5).toUpperCase()
        : value.toUpperCase();
  }
}

class SingleVision extends BaseLens {
  final MaterialType materialType;
  final int index;

  SingleVision({
    required super.companyName,
    required super.name,
    required super.spherical,
    required super.cylindrical,
    required super.pair,
    required super.diameter,
    required super.purchasePrice,
    required super.salesPrice,
    required this.materialType,
    required this.index,
  });

  @override
  String get productCode =>
      'LENS-SV-${_shorten(name)}-${_shorten(companyName)}';
}

class Bifocal extends SingleVision {
  final int axis;
  final double add;

  Bifocal({
    required super.companyName,
    required super.name,
    required super.spherical,
    required super.cylindrical,
    required super.pair,
    required super.diameter,
    required super.purchasePrice,
    required super.salesPrice,
    required super.materialType,
    required super.index,
    required this.axis,
    required this.add,
  });

  @override
  String get productCode =>
      'LENS-BF-${_shorten(name)}-${_shorten(companyName)}';
}

class ContactLens extends BaseLens {
  final int axis;
  final int baseCurve;

  ContactLens({
    required super.companyName,
    required super.name,
    required super.spherical,
    required super.cylindrical,
    required super.pair,
    required super.diameter,
    required super.purchasePrice,
    required super.salesPrice,
    required this.axis,
    required this.baseCurve,
  });

  @override
  String get productCode =>
      'LENS-CL-${_shorten(name)}-${_shorten(companyName)}';
}

class Progressive extends Bifocal {
  final ProgressiveLensSide side;

  Progressive({
    required super.companyName,
    required super.name,
    required super.spherical,
    required super.cylindrical,
    required super.pair,
    required super.diameter,
    required super.purchasePrice,
    required super.salesPrice,
    required super.materialType,
    required super.index,
    required super.axis,
    required super.add,
    required this.side,
  });

  @override
  String get productCode =>
      'LENS-PG-${_shorten(name)}-${_shorten(companyName)}';
}

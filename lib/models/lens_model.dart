enum MaterialType { mineral, plastic, polycarbonate, trivex, organic }

enum ProgressiveLensSide { right, left }

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
      'LENS-SV-${name.substring(0, 5).toUpperCase()}-${companyName.substring(0, 5).toUpperCase()}';
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
      'LENS-BF-${name.substring(0, 5).toUpperCase()}-${companyName.substring(0, 5).toUpperCase()}';
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
      'LENS-CL-${name.substring(0, 5).toUpperCase()}-${companyName.substring(0, 5).toUpperCase()}';
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
      'LENS-PG-${name.substring(0, 5).toUpperCase()}-${companyName.substring(0, 5).toUpperCase()}';
}

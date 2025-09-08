import 'package:isar/isar.dart';

@Enumerated(EnumType.name)
enum LensType { singleVision, bifocal, progressive, contactLens }

extension LensTypeExtension on LensType {
  String get displayName {
    switch (this) {
      case LensType.singleVision:
        return 'Single Vision';
      case LensType.bifocal:
        return 'Bifocal';
      case LensType.progressive:
        return 'Progressive';
      case LensType.contactLens:
        return 'Contact Lens';
    }
  }

  static LensType? fromString(String value) {
    return LensType.values.firstWhere(
      (e) => e.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => LensType.singleVision,
    );
  }
}

@Enumerated(EnumType.name)
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

@Enumerated(EnumType.name)
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

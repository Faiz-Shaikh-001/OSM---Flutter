enum LensType {
  singleVision,
  bifocal,
  progressive,
  contactLens,
}

enum LensMaterialType {
  mineral,
  plastic,
  polycarbonate,
  trivex,
  organic,
}

enum ProgressiveLensSide {
  right,
  left,
}

extension LensMaterialTypeX on LensMaterialType {
  String get label {
    switch (this) {
      case LensMaterialType.mineral:
      return "Mineral";
      case LensMaterialType.plastic:
      return "Plastic";
      case LensMaterialType.polycarbonate:
      return "Polycarbonate";
      case LensMaterialType.trivex:
      return "Trivex";
      case LensMaterialType.organic:
      return "Organic";
    }
  }
}

extension LensTypeX on LensType {
  String get label {
    switch (this) {
      case LensType.singleVision:
      return "Single Vision";
      case LensType.bifocal:
      return "Bifocal";
      case LensType.progressive:
      return "Progressive";
      case LensType.contactLens:
      return "Contact Lens";
    }
  }
}

extension ProgressiveLensSideX on ProgressiveLensSide {
  String get label {
    switch (this) {
      case ProgressiveLensSide.left:
      return "Left";
      case ProgressiveLensSide.right:
      return "Right";
    }
  }
}
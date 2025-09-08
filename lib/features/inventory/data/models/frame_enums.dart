import 'package:isar/isar.dart';

@Enumerated(EnumType.name)
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

enum FrameType { rimless, halfRimless, fullMetal, fullShell, goggles, custom }

extension FrameTypeX on FrameType {
  String get label {
    switch (this) {
      case FrameType.rimless:
        return 'Rimless';
      case FrameType.halfRimless:
        return 'Half Rimless';
      case FrameType.fullMetal:
        return 'Full Metal';
      case FrameType.fullShell:
        return 'Full Shell';
      case FrameType.goggles:
        return 'Goggles';
      case FrameType.custom:
        return 'Custom';
    }
  }
}

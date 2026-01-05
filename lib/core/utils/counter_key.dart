enum CounterScope {
  frameVariant,
  lens,
  accessory,
}

class CounterKey {
  static String _norm(String input, {int max = 4}) {
    final clean = input
        .replaceAll(RegExp(r'[^A-Za-z0-9]'), '')
        .toUpperCase();
    return clean.length > max ? clean.substring(0, max) : clean;
  }

  static String frameVariant({
    required String company,
    required String type,
  }) {
    return [
      CounterScope.frameVariant.name.toUpperCase(),
      _norm(company, max: 3),
      _norm(type, max: 4),
    ].join('_');
  }

  static String lens({
    required String company,
    required String lensType,
  }) {
    return [
      CounterScope.lens.name.toUpperCase(),
      _norm(company, max: 3),
      _norm(lensType, max: 4),
    ].join('_');
  }

  static String accessory({
    required String brand,
    required String category,
  }) {
    return [
      CounterScope.accessory.name.toUpperCase(),
      _norm(brand, max: 3),
      _norm(category, max: 4),
    ].join('_');
  }
}
  
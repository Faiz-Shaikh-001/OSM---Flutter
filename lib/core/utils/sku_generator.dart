class SkuGenerator {
  static String _norm(String v, {int max = 4}) {
    final clean = v
        .replaceAll(RegExp(r'[^A-Za-z0-9]'), '')
        .toUpperCase();
    return clean.length > max ? clean.substring(0, max) : clean;
  }

  static String _seq(int n) => n.toString().padLeft(3, '0');

  static String frameVariantSku({
    required String company,
    required String name,
    required String type,
    required int size,
    required String color,
    required int sequence,
  }) {
    return [
      'FRM',
      _norm(company, max: 3),
      _norm(name, max: 3),
      _norm(type, max: 4),
      size,
      _norm(color, max: 3),
      _seq(sequence),
    ].join('-');
  }

  static String lensSku({
    required String company,
    required String lensType,
    required double minIndex,
    required double maxIndex,
    required int sequence,
  }) {
    return [
      'LNS',
      _norm(company, max: 3),
      _norm(lensType, max: 4),
      minIndex.toStringAsFixed(2),
      maxIndex.toStringAsFixed(2),
      _seq(sequence),
    ].join('-');
  }

  static String accessorySku({
    required String brand,
    required String category,
    required int sequence,
  }) {
    return [
      'ACC',
      _norm(brand, max: 3),
      _norm(category, max: 5),
      _seq(sequence),
    ].join('-');
  }
}

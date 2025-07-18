import '../utils/get_product_code.dart';

enum FrameType { rimless, halfRimless, fullMetal, fullShell, goggles }

class Frame {
  final DateTime date;
  final FrameType frameType;
  final String name;
  final String code;
  final String color;
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
    required this.size,
    this.quantity = 0,
    this.purchasePrice = 0,
    this.salesPrice = 0,
  }) : date = date ?? DateTime.now();

  String getProductCode() {
    final frameCode = FrameTypeHelper.getFrameTypeCode(frameType);
    return "FRAME-$frameCode-$code-${color.substring(0, 4)}-$size";
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

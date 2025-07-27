import 'package:osm/data/models/frame_enums.dart';

String generateFrameCode({
  required String prefix,
  required FrameType frameType,
  required String code,
  required String color,
  required int size,
}) {
  final typeCodeMap = {
    FrameType.rimless: 1,
    FrameType.halfRimless: 2,
    FrameType.fullMetal: 3,
    FrameType.fullShell: 4,
    FrameType.goggles: 5,
  };

  return '$prefix-${typeCodeMap[frameType]}-$code-${color.substring(0, 4)}-$size';
}

import 'package:osm/core/value_objects/id.dart';

import 'frame_type.dart';
import 'frame_variant.dart';

class Frame {
  final FrameId id;
  final DateTime createdAt;
  final String companyName;
  final String name;
  final FrameType type;
  final List<FrameVariant> variants;

  Frame({
    required this.id,
    required this.createdAt,
    required this.companyName,
    required this.name,
    required this.type,
    required this.variants,
  });
}

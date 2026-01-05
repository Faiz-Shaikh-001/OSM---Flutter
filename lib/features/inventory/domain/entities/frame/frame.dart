import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/failures/frames/frame_failure.dart';

import 'frame_type.dart';
import 'frame_variant.dart';

class Frame {
  final String qrKey;
  final FrameId? id;
  final DateTime createdAt;
  final String companyName;
  final String name;
  final FrameType type;
  final String? customTypeName;
  final List<FrameVariant> variants;

  Frame({
    required this.qrKey,
    this.id,
    required this.createdAt,
    required this.companyName,
    required this.name,
    required this.type,
    this.customTypeName,
    required this.variants,
  }) {
    _validate();
  }

  void _validate() {
    if (type == FrameType.custom &&
        (customTypeName == null || customTypeName!.trim().isEmpty)) {
      throw FrameValidationFailure("Custom frame type name is required");
    }
  }
}

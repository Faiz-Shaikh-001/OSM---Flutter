import 'package:osm/features/inventory/domain/entities/frame/frame_type.dart';
import 'frame_variant_input.dart';

class CreateFrameInput {
  final String companyName;
  final String name;
  final FrameType type;
  final String? customTypeName;
  final List<FrameVariantInput> variants;
  final String qrKey;

  CreateFrameInput({
    required this.qrKey,
    required this.companyName,
    required this.name,
    required this.type,
    this.customTypeName,
    required this.variants,
  });
}

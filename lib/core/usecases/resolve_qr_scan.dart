import 'package:osm/core/value_objects/qr_scan_result.dart';
import 'package:osm/features/inventory/domain/repositories/accessory_repository.dart';
import 'package:osm/features/inventory/domain/repositories/frame_repository.dart';
import 'package:osm/features/inventory/domain/repositories/lens_repository.dart';

class ResolveQrScan {
  final FrameRepository _frameRepository;
  final LensRepository _lensRepository;
  final AccessoryRepository _accessoryRepository;

  ResolveQrScan(this._frameRepository, this._lensRepository, this._accessoryRepository);

  Future<QrScanResult?> execute(String rawValue) async {
    if (!rawValue.startsWith('frame:')) {
      return null;
    }
    final parts = rawValue.split(':');
    
    if (parts.length != 2) {
      return null;
    }

    final type = parts[0];
    final qrKey = parts[1];
    
    switch (type) {
      case 'frame':
        final frame =
            await _frameRepository.getByQrKey(qrKey);

        if (frame == null) return null;

        return QrScanResult.frame(int.parse(frame.id!.value));

      case 'lens':
        final lens = await _lensRepository.getByQrKey(qrKey);
        if (lens == null) return null;

        return QrScanResult.lens(int.parse(lens.id!.value));
      
      case 'accessory':
        final accessory = await _accessoryRepository.getByQrKey(qrKey);
        if (accessory == null) return null;

        return QrScanResult.accessory(int.parse(accessory.id!.value));
      default:
        return null;
    }
  }
}
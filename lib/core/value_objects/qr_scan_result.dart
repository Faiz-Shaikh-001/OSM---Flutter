class QrScanResult {
  final int id;
  final QrTargetType type;

  QrScanResult._(this.id, this.type);

  factory QrScanResult.frame(int frameId) =>
      QrScanResult._(frameId, QrTargetType.frame);
  
  factory QrScanResult.lens(int lensId) =>
      QrScanResult._(lensId, QrTargetType.lens); 

  factory QrScanResult.accessory(int accessoryId) =>
      QrScanResult._(accessoryId, QrTargetType.accessory);
}

enum QrTargetType { frame, lens, accessory }
part of 'qr_scan_bloc.dart';

@immutable
sealed class QrScanState {}

final class QrScanInitial extends QrScanState {}

final class QrScanLoading extends QrScanState {}

class QrScanInvalid extends QrScanState {}

class QrNavigateToFrame extends QrScanState {
  final int frameId;

  QrNavigateToFrame(this.frameId);
}

class QrNavigateToLens extends QrScanState {
  final int lensId;

  QrNavigateToLens(this.lensId);
}

class QrNavigateToAccessory extends QrScanState {
  final int accessoryId;

  QrNavigateToAccessory(this.accessoryId);
}
part of 'qr_scan_bloc.dart';

@immutable
sealed class QrScanEvent {}

final class QrScanned extends QrScanEvent {
  final String rawValue;

  QrScanned(this.rawValue);
}
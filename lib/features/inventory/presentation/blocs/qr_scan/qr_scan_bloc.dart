import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/qr_scan_result.dart';
import 'package:osm/core/usecases/resolve_qr_scan.dart';

part 'qr_scan_event.dart';
part 'qr_scan_state.dart';

class QrScanBloc extends Bloc<QrScanEvent, QrScanState> {
  final ResolveQrScan resolveQrScan;
  QrScanBloc({required this.resolveQrScan}) : super(QrScanInitial()) {
    on<QrScanned>(_onQrScanned);
  }

  Future<void> _onQrScanned(QrScanned event, Emitter<QrScanState> emit) async {
    emit(QrScanLoading());
    final result = await resolveQrScan.execute(event.rawValue);

    if (result == null) {
      emit(QrScanInvalid());
      return;
    }

    switch (result.type) {
      case QrTargetType.frame:
        emit(QrNavigateToFrame(result.id));
        break;
      case QrTargetType.lens:
        emit(QrNavigateToLens(result.id));
        break;
      case QrTargetType.accessory:
        emit(QrNavigateToAccessory(result.id));
        break;
    }
  }
}

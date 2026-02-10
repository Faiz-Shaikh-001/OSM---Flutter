import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/usecases/frames/get_frame_by_id.dart';

part 'frame_detail_event.dart';
part 'frame_detail_state.dart';

class FrameDetailBloc extends Bloc<FrameDetailEvent, FrameDetailState> {
  final GetFrameById getFrameById;

  FrameDetailBloc(this.getFrameById) : super(FrameDetailInitial()) {
    on<GetFrameByIdEvent>(_onGetById);
  }

  Future<void> _onGetById(
    GetFrameByIdEvent event,
    Emitter<FrameDetailState> emit,
  ) async {
    emit(FrameDetailLoading());

    final result = await getFrameById(event.id);
    result.fold(
      (f) => emit(FrameDetailError(f.message)),
      (frame) => emit(FrameDetailLoaded(frame)),
    );
  }
}


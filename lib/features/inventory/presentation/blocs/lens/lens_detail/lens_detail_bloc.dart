import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/usecases/lens/get_lens_by_id.dart';

part 'lens_detail_event.dart';
part 'lens_detail_state.dart';

class LensDetailBloc extends Bloc<LensDetailEvent, LensDetailState> {
  final GetLensById getLensById;
  LensDetailBloc(this.getLensById) : super(LensDetailInitial()) {
    on<GetLensByIdEvent>(_onGetById);
  }

  Future<void> _onGetById(
    GetLensByIdEvent event,
    Emitter<LensDetailState> emit,
  ) async {
    emit(LensDetailLoading());

    final result = await getLensById(event.id);

    result.fold(
      (f) => emit(LensDetailError(f.message)),
      (lens) => emit(LensDetailLoaded(lens)),
    );
  }
}

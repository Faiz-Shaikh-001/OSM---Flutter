import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/get_accessory_by_id.dart';

part 'accessory_detail_event.dart';
part 'accessory_detail_state.dart';

class AccessoryDetailBloc extends Bloc<AccessoryDetailEvent, AccessoryDetailState> {
  final GetAccessoryById getAccessoryById;
  AccessoryDetailBloc({required this.getAccessoryById}) : super(AccessoryDetailInitial()) {
    on<GetAccessoryByIdEvent>(_onGetById);
  }

  Future<void> _onGetById(
    GetAccessoryByIdEvent event,
    Emitter<AccessoryDetailState> emit,
  ) async {
    emit(AccessoryDetailLoading());

    final result = await getAccessoryById(event.id);
    result.fold(
      (f) => emit(AccessoryDetailError(f.message)),
      (accessory) => emit(AccessoryDetailLoaded(accessory)),
    );
  }
}

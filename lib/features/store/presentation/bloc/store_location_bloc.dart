import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/store/domain/entities/store_location.dart';
import 'package:osm/features/store/domain/failures/store_location_failure.dart';
import 'package:osm/features/store/domain/usecases/get_all_store_location.dart';
import 'package:osm/features/store/domain/usecases/get_store_locations.dart';
import 'package:osm/features/store/domain/usecases/set_active_store_location.dart';

part 'store_location_event.dart';
part 'store_location_state.dart';

class StoreLocationBloc extends Bloc<StoreLocationEvent, StoreLocationState> {
  final GetStoreLocations getStoreLocations;
  final GetAllStoreLocation getAllStoreLocation;
  final SetActiveStoreLocation setActiveStoreLocation;
  StoreLocationBloc({required this.getStoreLocations, required this.getAllStoreLocation, required this.setActiveStoreLocation})
    : super(StoreLocationInitial()) {
    on<LoadStoreLocations>(_onLoad);
    on<SetActiveStoreLocationEvent>(_onSetActive);
  }

  Future<void> _onLoad(
    LoadStoreLocations event,
    Emitter<StoreLocationState> emit,
  ) async {
    emit(StoreLocationLoading());

    final activeResult = await getStoreLocations();

    StoreLocation? activeStore;
    // ignore: unused_local_variable
    StoreLocationFailure? activeFailure;

    activeResult.fold(
      (failure) => activeFailure = failure,
      (store) => activeStore = store,
    );

    final allResult = await getAllStoreLocation();

    allResult.fold(
      (failure) {
        emit(StoreLocationError(failure.message));
      },
      (stores) {
        if (stores.isEmpty) {
          emit(StoreLocationError('No store locations available'));
          return;
        }

        emit(StoreLocationLoaded(stores: stores, activeStore: activeStore));
      },
    );
  }

  Future<void> _onSetActive(
    SetActiveStoreLocationEvent event,
    Emitter<StoreLocationState> emit,
  ) async {
    final result = await setActiveStoreLocation(event.id);

    result.fold(
      (failure) => emit(StoreLocationError(failure.message)),
      (_) => add(LoadStoreLocations()),
    );
  }
}

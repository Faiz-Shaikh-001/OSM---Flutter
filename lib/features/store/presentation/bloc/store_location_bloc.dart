import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/store/domain/entities/store_location.dart';
import 'package:osm/features/store/domain/failures/store_location_failure.dart';
import 'package:osm/features/store/domain/usecases/get_all_store_location.dart';
import 'package:osm/features/store/domain/usecases/get_store_locations.dart';
import 'package:osm/features/store/domain/usecases/set_active_store_location.dart';
import 'package:osm/features/store/domain/usecases/add_store_location.dart';
import 'package:osm/features/store/domain/usecases/update_store_location.dart';
import 'package:osm/features/store/domain/usecases/delete_store_location.dart';

part 'store_location_event.dart';
part 'store_location_state.dart';

class StoreLocationBloc
    extends Bloc<StoreLocationEvent, StoreLocationState> {
  final GetStoreLocations getStoreLocations;
  final GetAllStoreLocation getAllStoreLocation;
  final SetActiveStoreLocation setActiveStoreLocation;
  final AddStoreLocation addStoreLocation;
  final UpdateStoreLocation updateStoreLocation;
  final DeleteStoreLocation deleteStoreLocation;

  StoreLocationBloc({
    required this.getStoreLocations,
    required this.getAllStoreLocation,
    required this.setActiveStoreLocation,
    required this.addStoreLocation,
    required this.updateStoreLocation,
    required this.deleteStoreLocation,
  }) : super(StoreLocationInitial()) {
    on<LoadStoreLocations>(_onLoad);
    on<SetActiveStoreLocationEvent>(_onSetActive);
    on<AddStoreLocationEvent>(_onAdd);
    on<UpdateStoreLocationEvent>(_onUpdate);
    on<DeleteStoreLocationEvent>(_onDelete);
  }

  // ───────────────── Load Stores ─────────────────
  Future<void> _onLoad(
    LoadStoreLocations event,
    Emitter<StoreLocationState> emit,
  ) async {
    emit(StoreLocationLoading());

    final activeResult = await getStoreLocations();
    final allResult = await getAllStoreLocation();

    StoreLocation? activeStore;

    activeResult.fold(
      (_) {},
      (store) => activeStore = store,
    );

    allResult.fold(
      (failure) => emit(StoreLocationError(failure.message)),
      (stores) => emit(
        StoreLocationLoaded(
          stores: stores,
          activeStore: activeStore,
        ),
      ),
    );
  }

  // ───────────────── Set Active Store ─────────────────
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

  // ───────────────── Add Store ─────────────────
  Future<void> _onAdd(
    AddStoreLocationEvent event,
    Emitter<StoreLocationState> emit,
  ) async {
    final result = await addStoreLocation(event.store);

    result.fold(
      (failure) => emit(StoreLocationError(failure.message)),
      (_) => add(LoadStoreLocations()),
    );
  }

  // ───────────────── Update Store ─────────────────
  Future<void> _onUpdate(
    UpdateStoreLocationEvent event,
    Emitter<StoreLocationState> emit,
  ) async {
    final result = await updateStoreLocation(event.store);

    result.fold(
      (failure) => emit(StoreLocationError(failure.message)),
      (_) => add(LoadStoreLocations()),
    );
  }

  // ───────────────── Delete Store ─────────────────
  Future<void> _onDelete(
    DeleteStoreLocationEvent event,
    Emitter<StoreLocationState> emit,
  ) async {
    final result = await deleteStoreLocation(event.id);

    result.fold(
      (failure) => emit(StoreLocationError(failure.message)),
      (_) => add(LoadStoreLocations()),
    );
  }
}
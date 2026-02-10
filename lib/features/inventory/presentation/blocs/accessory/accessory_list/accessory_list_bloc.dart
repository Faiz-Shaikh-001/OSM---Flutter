import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/create_accessory.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/delete_accessory.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/get_accessories_by_brand.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/get_accessories_by_name.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/get_all_accessories.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/update_accessory.dart';
import 'package:osm/features/inventory/presentation/dto/create_accessory_input.dart';

part 'accessory_list_event.dart';
part 'accessory_list_state.dart';

class AccessoryListBloc extends Bloc<AccessoryListEvent, AccessoryListState> {
  final GetAllAccessories getAllAccessories;
  final GetAccessoriesByBrand getAccessoriesByBrand;
  final GetAccessoriesByName getAccessoriesByName;
  final CreateAccessory createAccessory;
  final DeleteAccessory deleteAccessory;
  final UpdateAccessory updateAccessory;
  AccessoryListBloc({
    required this.getAllAccessories,
    required this.getAccessoriesByBrand,
    required this.getAccessoriesByName,
    required this.createAccessory,
    required this.deleteAccessory,
    required this.updateAccessory,
  }) : super(AccessoryListInitial()) {
    on<LoadAccessoriesEvent>(_onLoad);
    on<SearchAccessoriesByBrandEvent>(_onSearchByBrand);
    on<SearchAccessoriesByNameEvent>(_onSearchByName);
    on<CreateAccessoryEvent>(_onCreate);
    on<UpdateAccessoryEvent>(_onUpdate);
    on<DeleteAccessoryEvent>(_onDelete);
  }

  Future<void> _onLoad(
    LoadAccessoriesEvent event,
    Emitter<AccessoryListState> emit,
  ) async {
    emit(AccessoryListLoading());

    final result = await getAllAccessories();
    result.fold(
      (failure) => emit(AccessoryListError(failure.message)),
      (accessories) => emit(AccessoryListLoaded(accessories)),
    );
  }

  Future<void> _onSearchByBrand(
    SearchAccessoriesByBrandEvent event,
    Emitter<AccessoryListState> emit,
  ) async {
    emit(AccessoryListLoading());

    final result = await getAccessoriesByBrand(event.brand);
    result.fold(
      (failure) => emit(AccessoryListError(failure.message)),
      (accessories) => emit(AccessoryListLoaded(accessories)),
    );
  }

  Future<void> _onSearchByName(
    SearchAccessoriesByNameEvent event,
    Emitter<AccessoryListState> emit,
  ) async {
    emit(AccessoryListLoading());

    final result = await getAccessoriesByName(event.name);
    result.fold(
      (failure) => emit(AccessoryListError(failure.message)),
      (accessories) => emit(AccessoryListLoaded(accessories)),
    );
  }

  Future<void> _onCreate(
    CreateAccessoryEvent event,
    Emitter<AccessoryListState> emit,
  ) async {
    emit(AccessoryListLoading());

    final result = await createAccessory(event.input);
    result.fold(
      (failure) => emit(AccessoryListError(failure.message)),
      (success) => emit(AccessoryListActionSuccess(success.message)),
    );
  }

  Future<void> _onUpdate(
    UpdateAccessoryEvent event,
    Emitter<AccessoryListState> emit,
  ) async {
    emit(AccessoryListLoading());

    final result = await updateAccessory(event.accessory);
    result.fold(
      (failure) => emit(AccessoryListError(failure.message)),
      (success) => emit(AccessoryListActionSuccess(success.message)),
    );
  }

  Future<void> _onDelete(
    DeleteAccessoryEvent event,
    Emitter<AccessoryListState> emit,
  ) async {
    emit(AccessoryListLoading());

    final result = await deleteAccessory(event.id);
    result.fold(
      (failure) => emit(AccessoryListError(failure.message)),
      (success) => emit(AccessoryListActionSuccess(success.message)),
    );
  }
}

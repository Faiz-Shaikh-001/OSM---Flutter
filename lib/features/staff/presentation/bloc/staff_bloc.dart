import 'package:bloc/bloc.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/staff/domain/usecases/add_staff.dart';
import 'package:osm/features/staff/domain/usecases/delete_staff.dart';
import 'package:osm/features/staff/domain/usecases/get_staff.dart';
import 'package:osm/features/staff/domain/usecases/update_staff.dart';

import 'staff_event.dart';
import 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  final GetStaff getStaff;
  final AddStaff addStaff;
  final UpdateStaff updateStaff;
  final DeleteStaff deleteStaff;

  StoreLocationId? _currentStoreId;

  StaffBloc({
    required this.getStaff,
    required this.addStaff,
    required this.updateStaff,
    required this.deleteStaff,
  }) : super(StaffInitial()) {
    on<LoadStaff>(_onLoad);
    on<AddStaffEvent>(_onAdd);
    on<UpdateStaffEvent>(_onUpdate);
    on<DeleteStaffEvent>(_onDelete);
  }

  Future<void> _onLoad(
    LoadStaff event,
    Emitter<StaffState> emit,
  ) async {
    emit(StaffLoading());

    _currentStoreId = event.storeId;

    final result = await getStaff();

    result.fold(
      (error) => emit(StaffError(error)),
      (staff) => emit(StaffLoaded(staff)),
    );
  }

  Future<void> _onAdd(
    AddStaffEvent event,
    Emitter<StaffState> emit,
  ) async {
    await addStaff(event.staff);

    if (_currentStoreId != null) {
      add(LoadStaff(storeId: _currentStoreId!));
    }
  }

  Future<void> _onUpdate(
    UpdateStaffEvent event,
    Emitter<StaffState> emit,
  ) async {
    await updateStaff(event.staff);

    if (_currentStoreId != null) {
      add(LoadStaff(storeId: _currentStoreId!));
    }
  }

  Future<void> _onDelete(
    DeleteStaffEvent event,
    Emitter<StaffState> emit,
  ) async {
    await deleteStaff(event.id);

    if (_currentStoreId != null) {
      add(LoadStaff(storeId: _currentStoreId!));
    }
  }
}
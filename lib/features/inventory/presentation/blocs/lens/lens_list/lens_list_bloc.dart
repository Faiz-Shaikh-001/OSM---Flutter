import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens_type.dart';
import 'package:osm/features/inventory/domain/usecases/lens/create_lens.dart';
import 'package:osm/features/inventory/domain/usecases/lens/delete_lens.dart';
import 'package:osm/features/inventory/domain/usecases/lens/get_all_lenses.dart';
import 'package:osm/features/inventory/domain/usecases/lens/get_lenses_by_company.dart';
import 'package:osm/features/inventory/domain/usecases/lens/get_lenses_by_product_name.dart';
import 'package:osm/features/inventory/domain/usecases/lens/get_lenses_by_type.dart';
import 'package:osm/features/inventory/domain/usecases/lens/update_lens.dart';
import 'package:osm/features/inventory/presentation/dto/create_lens_input.dart';

part 'lens_list_event.dart';
part 'lens_list_state.dart';

class LensListBloc extends Bloc<LensListEvent, LensListState> {
  final GetAllLenses getAllLenses;
  final GetLensesByCompany getLensesByCompany;
  final GetLensesByProductName getLensesByProductName;
  final GetLensesByType getLensesByType;
  final CreateLens createLens;
  final UpdateLens updateLens;
  final DeleteLens deleteLens;
  LensListBloc({
    required this.getAllLenses,
    required this.getLensesByCompany,
    required this.getLensesByProductName,
    required this.getLensesByType,
    required this.createLens,
    required this.updateLens,
    required this.deleteLens,
  }) : super(LensListInitial()) {
    on<LoadLensesEvent>(_onLoad);
    on<SearchLensesByCompanyEvent>(_onSearchByCompany);
    on<SearchLensesByProductNameEvent>(_onSearchByName);
    on<SearchLensesByTypeEvent>(_onSearchByType);
    on<CreateLensEvent>(_onCreate);
    on<UpdateLensEvent>(_onUpdate);
    on<DeleteLensEvent>(_onDelete);
  }

  Future<void> _onLoad(
    LoadLensesEvent event,
    Emitter<LensListState> emit,
  ) async {
    emit(LensListLoading());

    final result = await getAllLenses();
    result.fold(
      (f) => emit(LensListError(f.message)),
      (lenses) => emit(LensListLoaded(lenses)),
    );
  }

  Future<void> _onSearchByCompany(
    SearchLensesByCompanyEvent event,
    Emitter<LensListState> emit,
  ) async {
    emit(LensListLoading());

    final result = await getLensesByCompany(event.companyName);

    result.fold(
      (f) => emit(LensListError(f.message)),
      (lenses) => emit(LensListLoaded(lenses)),
    );
  }

  Future<void> _onSearchByName(
    SearchLensesByProductNameEvent event,
    Emitter<LensListState> emit,
  ) async {
    emit(LensListLoading());

    final result = await getLensesByProductName(event.productName);

    result.fold(
      (f) => emit(LensListError(f.message)),
      (lenses) => emit(LensListLoaded(lenses)),
    );
  }

  Future<void> _onSearchByType(
    SearchLensesByTypeEvent event,
    Emitter<LensListState> emit,
  ) async {
    emit(LensListLoading());

    final result = await getLensesByType(event.type);

    result.fold(
      (f) => emit(LensListError(f.message)),
      (lenses) => emit(LensListLoaded(lenses)),
    );
  }

  Future<void> _onCreate(
    CreateLensEvent event,
    Emitter<LensListState> emit,
  ) async {
    emit(LensListLoading());

    final result = await createLens(event.input);

    result.fold((f) => emit(LensListError(f.message)), (success) {
      emit(LensListActionSuccess(success.message));
      add(LoadLensesEvent());
    });
  }

  Future<void> _onUpdate(
    UpdateLensEvent event,
    Emitter<LensListState> emit,
  ) async {
    emit(LensListLoading());

    final result = await updateLens(event.lens);

    result.fold((failure) => emit(LensListError(failure.message)), (success) {
      emit(LensListActionSuccess(success.message));
      add(LoadLensesEvent());
    });
  }

  Future<void> _onDelete(DeleteLensEvent event, emit) async {
    emit(LensListLoading());
    final result = await deleteLens(event.id);
    result.fold((failure) => emit(LensListError(failure.message)), (success) {
      emit(LensListActionSuccess(success.message));
      add(LoadLensesEvent());
    });
  }
}

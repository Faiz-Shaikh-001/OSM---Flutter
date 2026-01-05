import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame_type.dart';
import 'package:osm/features/inventory/domain/usecases/frames/create_frame.dart';
import 'package:osm/features/inventory/domain/usecases/frames/delete_frame.dart';
import 'package:osm/features/inventory/domain/usecases/frames/get_all_frames.dart';
import 'package:osm/features/inventory/domain/usecases/frames/get_by_type.dart';
import 'package:osm/features/inventory/domain/usecases/frames/get_frames_by_company.dart';
import 'package:osm/features/inventory/domain/usecases/frames/get_frames_by_name.dart';
import 'package:osm/features/inventory/domain/usecases/frames/update_frame.dart';
import 'package:osm/features/inventory/presentation/dto/create_frame_input.dart';

part 'frame_list_event.dart';
part 'frame_list_state.dart';

class FrameListBloc extends Bloc<FrameListEvent, FrameListState> {
  final GetAllFrames getAllFrames;
  final GetFramesByCompany getFramesByCompany;
  final GetFramesByName getFramesByName;
  final GetFramesByType getFramesByType;
  final CreateFrame createFrame;
  final UpdateFrame updateFrame;
  final DeleteFrame deleteFrame;

  FrameListBloc({
    required this.getAllFrames,
    required this.getFramesByCompany,
    required this.getFramesByName,
    required this.getFramesByType,
    required this.createFrame,
    required this.updateFrame,
    required this.deleteFrame,
  }) : super(FrameListInitial()) {
    on<LoadFramesEvent>(_onLoad);
    on<SearchFramesByCompanyEvent>(_onSearchByCompany);
    on<SearchFramesByNameEvent>(_onSearchByName);
    on<SearchFramesByTypeEvent>(_onSearchByType);
    on<CreateFrameEvent>(_onCreate);
    on<UpdateFrameEvent>(_onUpdate);
    on<DeleteFrameEvent>(_onDelete);
  }

  Future<void> _onLoad(_, Emitter<FrameListState> emit) async {
    emit(FrameListLoading());
    final result = await getAllFrames();
    result.fold(
      (f) => emit(FrameListError(f.message)),
      (frames) => emit(FrameListLoaded(frames)),
    );
  }

  Future<void> _onSearchByCompany(
    SearchFramesByCompanyEvent event,
    Emitter<FrameListState> emit,
  ) async {
    emit(FrameListLoading());
    final result = await getFramesByCompany(event.companyName);
    result.fold(
      (f) => emit(FrameListError(f.message)),
      (frames) => emit(FrameListLoaded(frames)),
    );
  }

  Future<void> _onSearchByName(
    SearchFramesByNameEvent event,
    Emitter<FrameListState> emit,
  ) async {
    emit(FrameListLoading());
    final result = await getFramesByName(event.name);
    result.fold(
      (f) => emit(FrameListError(f.message)),
      (frames) => emit(FrameListLoaded(frames)),
    );
  }

  Future<void> _onSearchByType(
    SearchFramesByTypeEvent event,
    Emitter<FrameListState> emit,
  ) async {
    emit(FrameListLoading());
    final result = await getFramesByType(event.type);
    result.fold(
      (f) => emit(FrameListError(f.message)),
      (frames) => emit(FrameListLoaded(frames)),
    );
  }

  Future<void> _onCreate(
    CreateFrameEvent event,
    Emitter<FrameListState> emit,
  ) async {
    emit(FrameListLoading());
    final result = await createFrame(event.input);
    result.fold((failure) => emit(FrameListError(failure.message)), (success) {
      emit(FrameListActionSuccess(success.message));
      add(LoadFramesEvent());
    });
  }

  Future<void> _onUpdate(
    UpdateFrameEvent event,
    Emitter<FrameListState> emit,
  ) async {
    emit(FrameListLoading());
    final result = await updateFrame(event.frame);
    result.fold((failure) => emit(FrameListError(failure.message)), (success) {
      emit(FrameListActionSuccess(success.message));
      add(LoadFramesEvent());
    });
  }

  Future<void> _onDelete(
    DeleteFrameEvent event,
    Emitter<FrameListState> emit,
  ) async {
    emit(FrameListLoading());
    final result = await deleteFrame(event.id);
    result.fold((failure) => emit(FrameListError(failure.message)), (success) {
      emit(FrameListActionSuccess(success.message));
      add(LoadFramesEvent());
    });
  }
}

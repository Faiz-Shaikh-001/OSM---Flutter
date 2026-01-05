part of 'frame_list_bloc.dart';

@immutable
sealed class FrameListState {}

class FrameListInitial extends FrameListState {}

class FrameListLoading extends FrameListState {}

class FrameListLoaded extends FrameListState {
  final List<Frame> frames;
  FrameListLoaded(this.frames);
}

class FrameListActionSuccess extends FrameListState {
  final String message;
  FrameListActionSuccess(this.message);
}

class FrameListError extends FrameListState {
  final String message;
  FrameListError(this.message);
}

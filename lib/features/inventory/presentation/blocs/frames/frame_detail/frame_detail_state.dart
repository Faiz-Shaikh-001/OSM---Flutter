part of 'frame_detail_bloc.dart';

@immutable
sealed class FrameDetailState {}

class FrameDetailInitial extends FrameDetailState {}

class FrameDetailLoading extends FrameDetailState {}

class FrameDetailLoaded extends FrameDetailState {
  final Frame frame;
  FrameDetailLoaded(this.frame);
}

class FrameDetailError extends FrameDetailState {
  final String message;
  FrameDetailError(this.message);
}

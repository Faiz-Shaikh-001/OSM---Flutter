part of 'frame_detail_bloc.dart';

@immutable
sealed class FrameDetailEvent {}

class GetFrameByIdEvent extends FrameDetailEvent {
  final FrameId id;
  GetFrameByIdEvent(this.id);
}


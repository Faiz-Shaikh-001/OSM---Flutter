part of 'frame_list_bloc.dart';

@immutable
sealed class FrameListEvent {}

class LoadFramesEvent extends FrameListEvent {}

class SearchFramesByCompanyEvent extends FrameListEvent {
  final String companyName;
  SearchFramesByCompanyEvent(this.companyName);
}

class SearchFramesByNameEvent extends FrameListEvent {
  final String name;
  SearchFramesByNameEvent(this.name);
}

class SearchFramesByTypeEvent extends FrameListEvent {
  final FrameType type;
  SearchFramesByTypeEvent(this.type);
}

class CreateFrameEvent extends FrameListEvent {
  final CreateFrameInput input;
  CreateFrameEvent(this.input);
}

class UpdateFrameEvent extends FrameListEvent {
  final Frame frame;
  UpdateFrameEvent(this.frame);
}

class DeleteFrameEvent extends FrameListEvent {
  final FrameId id;
  DeleteFrameEvent(this.id);
}
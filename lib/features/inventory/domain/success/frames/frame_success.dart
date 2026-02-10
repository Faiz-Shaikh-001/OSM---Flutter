import 'package:osm/core/value_objects/id.dart';

abstract class FrameSuccess {
  final String message;
  const FrameSuccess(this.message);
}

class FrameCreatedSuccess extends FrameSuccess {
  final FrameId id;

  const FrameCreatedSuccess(this.id)
      : super('Frame created successfully');
}


class FrameUpdatedSuccess extends FrameSuccess {
  final FrameId id;

  const FrameUpdatedSuccess(this.id)
      : super('Frame updated successfully');
}


class FrameDeletedSuccess extends FrameSuccess {
  final bool deleted;

  const FrameDeletedSuccess(this.deleted)
      : super('Frame deleted successfully');
}

class FrameDeactivatedSuccess extends FrameSuccess {
  final FrameId id;

  const FrameDeactivatedSuccess(this.id)
      : super('Frame deactivated successfully');
}

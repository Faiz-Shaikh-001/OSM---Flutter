import 'package:osm/core/value_objects/id.dart';

abstract class FrameSuccess {
  const FrameSuccess();
}

class FrameCreatedSuccess extends FrameSuccess {
  final FrameId id;
  const FrameCreatedSuccess(this.id);
}

class FrameUpdatedSuccess extends FrameSuccess {
  const FrameUpdatedSuccess();
}

class FrameDeletedSuccess extends FrameSuccess {
  const FrameDeletedSuccess();
}

import 'package:osm/core/value_objects/id.dart';

abstract class LensSuccess {
  final String message;
  const LensSuccess(this.message);
}

class LensCreatedSuccess extends LensSuccess {
  final LensId id;

  const LensCreatedSuccess(this.id) : super('Lens created successfully');
}

class LensUpdatedSuccess extends LensSuccess {
  final LensId id;

  const LensUpdatedSuccess(this.id) : super('Lens updated successfully');
}

class LensDeletedSuccess extends LensSuccess {
  final bool deleted;

  const LensDeletedSuccess(this.deleted) : super('Lens deleted successfully');
}

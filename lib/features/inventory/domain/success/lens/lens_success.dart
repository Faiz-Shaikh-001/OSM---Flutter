import 'package:osm/core/value_objects/id.dart';

abstract class LensSuccess {
  const LensSuccess();
}

class LensCreatedSuccess extends LensSuccess {
  final LensId id;
  const LensCreatedSuccess(this.id);
}

class LensUpdatedSuccess extends LensSuccess {
  const LensUpdatedSuccess();
}

class LensDeletedSuccess extends LensSuccess {
  const LensDeletedSuccess();
}

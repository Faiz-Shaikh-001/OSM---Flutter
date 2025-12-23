import 'package:osm/core/value_objects/id.dart';

abstract class AccessorySuccess {
  const AccessorySuccess();
}

class AccessoryCreatedSuccess extends AccessorySuccess {
  final AccessoryId id;
  const AccessoryCreatedSuccess(this.id);
}

class AccessoryUpdatedSuccess extends AccessorySuccess {
  const AccessoryUpdatedSuccess();
}

class AccessoryDeletedSuccess extends AccessorySuccess {
  const AccessoryDeletedSuccess();
}

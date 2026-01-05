import 'package:osm/core/value_objects/id.dart';

abstract class AccessorySuccess {
  final String message;
  const AccessorySuccess(this.message);
}

class AccessoryCreatedSuccess extends AccessorySuccess {
  final AccessoryId id;
  const AccessoryCreatedSuccess(this.id)
    : super("Accessory created successfully.");
}

class AccessoryUpdatedSuccess extends AccessorySuccess {
  const AccessoryUpdatedSuccess(super.message);
}

class AccessoryDeletedSuccess extends AccessorySuccess {
  const AccessoryDeletedSuccess(super.message);
}

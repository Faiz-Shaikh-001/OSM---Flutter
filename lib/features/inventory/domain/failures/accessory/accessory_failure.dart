abstract class AccessoryFailure {
  final String message;
  const AccessoryFailure(this.message);
}

class AccessoryNotFoundFailure extends AccessoryFailure {
  const AccessoryNotFoundFailure() : super('Accessory not found');
}

class AccessoryValidationFailure extends AccessoryFailure {
  const AccessoryValidationFailure(super.message);
}

class AccessoryConflictFailure extends AccessoryFailure {
  const AccessoryConflictFailure(super.message);
}

class AccessoryStorageFailure extends AccessoryFailure {
  const AccessoryStorageFailure([super.message = 'Failed to save accessory']);
}

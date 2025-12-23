abstract class AccessoryFailure {
  final String message;
  const AccessoryFailure(this.message);
}

class AccessoryNotFoundFailure extends AccessoryFailure {
  const AccessoryNotFoundFailure(super.message);
}

class AccessoryValidationFailure extends AccessoryFailure {
  
  const AccessoryValidationFailure(super.message);
}

class AccessoryStorageFailure extends AccessoryFailure {
  const AccessoryStorageFailure(super.message);
}

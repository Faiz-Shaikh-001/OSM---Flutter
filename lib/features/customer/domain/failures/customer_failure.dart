abstract class CustomerFailure {
  final String message;
  const CustomerFailure(this.message);
}

class CustomerAlreadyExistsFailure extends CustomerFailure {
  const CustomerAlreadyExistsFailure()
      : super('Customer with this phone number already exists');
}

class CustomerNotFoundFailure extends CustomerFailure {
  const CustomerNotFoundFailure()
      : super('Customer not found');
}

class CustomerHasRelationsFailure extends CustomerFailure {
  const CustomerHasRelationsFailure()
      : super('Customer has related records and cannot be deleted');
}

class CustomerUnknownFailure extends CustomerFailure {
  const CustomerUnknownFailure()
      : super('Unexpected customer error');
}

class CustomerDuplicatePhoneFailure extends CustomerFailure {
  const CustomerDuplicatePhoneFailure() : super("Phone number already in use");
}

class CustomerValidationFailure extends CustomerFailure {
  const CustomerValidationFailure(super.message);
}
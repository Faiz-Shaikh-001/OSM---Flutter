abstract class StoreLocationFailure {
  final String message;
  const StoreLocationFailure(this.message);
}

class StoreFailure extends StoreLocationFailure {
  const StoreFailure(super.message);
}

class NoActiveStoreFailure extends StoreFailure {
  const NoActiveStoreFailure() : super('No active store selected');
}

class StoreNotFoundFailure extends StoreFailure {
  const StoreNotFoundFailure() : super('Store not found');
}

class NoStoreLocationsFailure extends StoreFailure {
  const NoStoreLocationsFailure() : super('No store locations available');
}

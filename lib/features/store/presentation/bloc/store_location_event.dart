part of 'store_location_bloc.dart';

@immutable
sealed class StoreLocationEvent {}

/// Load all stores + active store
class LoadStoreLocations extends StoreLocationEvent {}

/// Set active store
class SetActiveStoreLocationEvent extends StoreLocationEvent {
  final StoreLocationId id;
  SetActiveStoreLocationEvent(this.id);
}

/// Add new store
class AddStoreLocationEvent extends StoreLocationEvent {
  final StoreLocation store;
  AddStoreLocationEvent(this.store);
}

/// Update existing store
class UpdateStoreLocationEvent extends StoreLocationEvent {
  final StoreLocation store;
  UpdateStoreLocationEvent(this.store);
}

/// Delete store
class DeleteStoreLocationEvent extends StoreLocationEvent {
  final StoreLocationId id;
  DeleteStoreLocationEvent(this.id);
}
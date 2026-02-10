part of 'store_location_bloc.dart';

@immutable
sealed class StoreLocationEvent {}

class LoadStoreLocations extends StoreLocationEvent {}

class SetActiveStoreLocationEvent extends StoreLocationEvent {
  final StoreLocationId id;
  SetActiveStoreLocationEvent(this.id);
}

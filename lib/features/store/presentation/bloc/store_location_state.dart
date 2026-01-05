part of 'store_location_bloc.dart';

@immutable
sealed class StoreLocationState {}

final class StoreLocationInitial extends StoreLocationState {}

class StoreLocationLoading extends StoreLocationState {}

class StoreLocationLoaded extends StoreLocationState {
  final List<StoreLocation> stores;
  final StoreLocation? activeStore;

  StoreLocationLoaded({required this.stores, required this.activeStore});
}

class StoreLocationError extends StoreLocationState {
  final String message;
  StoreLocationError(this.message);
}
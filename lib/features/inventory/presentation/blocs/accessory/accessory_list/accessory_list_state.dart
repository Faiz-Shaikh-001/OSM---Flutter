part of 'accessory_list_bloc.dart';

@immutable
sealed class AccessoryListState {}

final class AccessoryListInitial extends AccessoryListState {}

class AccessoryListLoading extends AccessoryListState {}

class AccessoryListLoaded extends AccessoryListState {
  final List<Accessory> accessories;
  AccessoryListLoaded(this.accessories);
}

class AccessoryListError extends AccessoryListState {
  final String message;
  AccessoryListError(this.message);
}

class AccessoryListActionSuccess extends AccessoryListState {
  final String message;
  AccessoryListActionSuccess(this.message);
}

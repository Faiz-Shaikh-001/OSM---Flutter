part of 'accessory_detail_bloc.dart';

@immutable
sealed class AccessoryDetailState {}

final class AccessoryDetailInitial extends AccessoryDetailState {}

class AccessoryDetailLoading extends AccessoryDetailState {}

class AccessoryDetailLoaded extends AccessoryDetailState {
  final Accessory accessory;
  AccessoryDetailLoaded(this.accessory);
}

class AccessoryDetailError extends AccessoryDetailState {
  final String message;
  AccessoryDetailError(this.message);
}


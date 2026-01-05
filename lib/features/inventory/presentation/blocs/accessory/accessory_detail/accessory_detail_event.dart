part of 'accessory_detail_bloc.dart';

@immutable
sealed class AccessoryDetailEvent {}

class GetAccessoryByIdEvent extends AccessoryDetailEvent {
  final AccessoryId id;
  GetAccessoryByIdEvent(this.id);
}
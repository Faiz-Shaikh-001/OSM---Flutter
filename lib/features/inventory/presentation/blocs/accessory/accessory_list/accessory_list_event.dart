part of 'accessory_list_bloc.dart';

@immutable
sealed class AccessoryListEvent {}

class LoadAccessoriesEvent extends AccessoryListEvent {}

class SearchAccessoriesByBrandEvent extends AccessoryListEvent {
  final String brand;
  SearchAccessoriesByBrandEvent(this.brand);
}

class SearchAccessoriesByNameEvent extends AccessoryListEvent {
  final String name;
  SearchAccessoriesByNameEvent(this.name);
}

class CreateAccessoryEvent extends AccessoryListEvent {
  final CreateAccessoryInput input;
  CreateAccessoryEvent(this.input);
}

class UpdateAccessoryEvent extends AccessoryListEvent {
  final Accessory accessory;
  UpdateAccessoryEvent(this.accessory);
}

class DeleteAccessoryEvent extends AccessoryListEvent {
  final AccessoryId id;
  DeleteAccessoryEvent(this.id);
}

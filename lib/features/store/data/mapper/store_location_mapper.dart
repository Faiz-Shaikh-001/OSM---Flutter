import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/store/data/model/store_location_model.dart';

import '../../domain/entities/store_location.dart';

class StoreLocationMapper {
  static StoreLocation toEntity(StoreLocationModel model) {
    return StoreLocation(
      id: StoreLocationId(model.id.toString()),
      name: model.name,
      address: model.address,
      city: model.city,
      phoneNumber: model.phoneNumber,
      operatingHours: model.operatingHours,
      isActive: model.isActive,
      createdAt: model.createdAt,
    );
  }

  static StoreLocationModel toModel(StoreLocation entity) {
    return StoreLocationModel(
      name: entity.name,
      address: entity.address,
      city: entity.city,
      phoneNumber: entity.phoneNumber,
      operatingHours: entity.operatingHours,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
    );
  }
}

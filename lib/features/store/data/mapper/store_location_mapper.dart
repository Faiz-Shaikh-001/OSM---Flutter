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
      state: model.state,
      country: model.country,
      postalCode: model.postalCode,
      phoneNumber: model.phoneNumber,
      operatingHours: model.operatingHours,
      isActive: model.isActive,
      createdAt: model.createdAt,
      licenseNumber: model.licenseNumber,
      storeLogoUrl: model.storeLogoUrl,
    );
  }

  static StoreLocationModel toModel(StoreLocation entity) {
    return StoreLocationModel(
      name: entity.name,
      address: entity.address,
      city: entity.city,
      state: entity.state,
      country: entity.country,
      postalCode: entity.postalCode,
      storeLogoUrl: entity.storeLogoUrl,
      phoneNumber: entity.phoneNumber,
      operatingHours: entity.operatingHours,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      licenseNumber: entity.licenseNumber,
    );
  }
}

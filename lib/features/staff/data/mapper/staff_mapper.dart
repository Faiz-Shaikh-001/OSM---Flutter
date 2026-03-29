import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/staff/data/models/staff_model.dart';
import 'package:osm/features/staff/domain/entities/staff.dart';

class StaffMapper {
  static Staff toEntity(StaffModel model) {
    return Staff(
      id: StaffId(model.id.toString()),
      name: model.name,
      phone: model.phone,
      email: model.email,
      role: model.role,
      storeId: StoreLocationId(model.storeId.toString()),
      isActive: model.isActive,
      createdAt: model.createdAt,
    );
  }

  static StaffModel toModel(Staff entity) {
    final model = StaffModel()
      ..name = entity.name
      ..phone = entity.phone
      ..email = entity.email
      ..role = entity.role
      ..storeId = int.parse(entity.storeId.value)
      ..isActive = entity.isActive
      ..createdAt = entity.createdAt;

    if (entity.id != null) {
      model.id = int.parse(entity.id!.value);
    }

    return model;
  }
}
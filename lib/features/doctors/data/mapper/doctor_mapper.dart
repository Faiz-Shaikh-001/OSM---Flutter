import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/doctors/data/models/doctor_model.dart';

import '../../domain/entities/doctor.dart';

class DoctorMapper {
  static Doctor toEntity(DoctorModel model) {
    final store = model.storeLocation.value;
    if (store == null) {
      throw StateError('DoctorModel.storeLocation not loaded');
    }

    return Doctor(
      id: DoctorId(model.id.toString()),
      createdAt: model.createdAt,
      name: model.name,
      designation: model.designation,
      hospital: model.hospital,
      city: model.city,
      storeLocationId: StoreLocationId(store.id.toString()),
      isActive: true,
    );
  }

  static DoctorModel toModel(Doctor entity) {
    return DoctorModel(
      createdAt: entity.createdAt,
      name: entity.name,
      designation: entity.designation,
      hospital: entity.hospital,
      city: entity.city,
      isActive: entity.isActive,
    );
  }
}

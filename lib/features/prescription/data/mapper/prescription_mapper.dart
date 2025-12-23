import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/prescription/data/models/prescription_model.dart';

import '../../domain/entities/prescription.dart';
class PrescriptionMapper {
  static Prescription toDomain(PrescriptionModel model) {
    final customer = model.customer.value;
    final doctor = model.doctor.value;

    if (customer == null || doctor == null) {
      throw StateError('PrescriptionModel relations not loaded');
    }

    return Prescription(
      id: PrescriptionId(model.id.toString()),
      createdAt: model.createdAt,
      sphereRight: model.sphereRight,
      cylinderRight: model.cylinderRight,
      axisRight: model.axisRight,
      addRight: model.addRight,
      sphereLeft: model.sphereLeft,
      cylinderLeft: model.cylinderLeft,
      axisLeft: model.axisLeft,
      addLeft: model.addLeft,
      pd: model.pd,
      notes: model.notes,
      customerId: CustomerId(customer.id.toString()),
      doctorId: DoctorId(doctor.id.toString()),
    );
  }

  static PrescriptionModel toModel(Prescription entity) {
    return PrescriptionModel(
      createdAt: entity.createdAt,
      sphereRight: entity.sphereRight,
      cylinderRight: entity.cylinderRight,
      axisRight: entity.axisRight,
      addRight: entity.addRight,
      sphereLeft: entity.sphereLeft,
      cylinderLeft: entity.cylinderLeft,
      axisLeft: entity.axisLeft,
      addLeft: entity.addLeft,
      pd: entity.pd,
      notes: entity.notes,
    );
  }
}

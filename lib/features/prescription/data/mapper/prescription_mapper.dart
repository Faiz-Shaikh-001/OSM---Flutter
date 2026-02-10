import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/data/models/customer_model.dart';
import 'package:osm/features/doctors/data/models/doctor_model.dart';
import 'package:osm/features/prescription/data/models/prescription_model.dart';
import 'package:osm/features/prescription/domain/value_objects/eye_power.dart';
import 'package:osm/features/prescription/domain/value_objects/pupillary_distance.dart';

import '../../domain/entities/prescription.dart';

class PrescriptionMapper {
  static Prescription toEntity(PrescriptionModel model) {
    final customer = model.customer.value;
    final doctor = model.doctor.value;

    if (customer == null) {
      throw StateError('PrescriptionModel relations not loaded');
    }

    return Prescription(
      id: PrescriptionId(model.id.toString()),
      createdAt: model.createdAt,
      prescriptionDate: model.prescriptionDate,
      source: model.source,
      doctorId: doctor != null ? DoctorId(doctor.id.toString()) : null,
      rightEye: EyePower(
        sphere: model.rightSphere,
        cylinder: model.rightCylinder,
        axis: model.rightAxis,
        add: model.rightAdd,
      ),
      leftEye: EyePower(
        sphere: model.leftSphere,
        cylinder: model.leftCylinder,
        axis: model.leftAxis,
        add: model.leftAdd,
      ),
      pd: PupillaryDistance(left: model.pdLeft ?? 0.0, right: model.pdRight ?? 0.0),
      notes: model.notes,
    );
  }

  static PrescriptionModel toModel(
    Prescription entity, {
    required CustomerModel customer,
    DoctorModel? doctor,
  }) {
    final model = PrescriptionModel(
      createdAt: entity.createdAt,
      notes: entity.notes,
    );
    model.prescriptionDate = entity.prescriptionDate;
    model.source = entity.source;

    model.rightSphere = entity.rightEye.sphere;
    model.rightCylinder = entity.rightEye.cylinder ?? 0.0;
    model.rightAxis = entity.rightEye.axis ?? 0;
    model.rightAdd = entity.rightEye.add ?? 0.0;

    model.leftSphere = entity.leftEye.sphere;
    model.leftCylinder = entity.leftEye.cylinder ?? 0.0;
    model.leftAxis = entity.leftEye.axis ?? 0;
    model.leftAdd = entity.leftEye.add ?? 0.0;

    model.pdRight = entity.pd?.right ?? 0;
    model.pdLeft = entity.pd?.left ?? 0;

    model.customer.value = customer;

    if (doctor != null) {
      model.doctor.value = doctor;
    }

    return model;
  }
}

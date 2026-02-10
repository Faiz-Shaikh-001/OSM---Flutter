import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/prescription/domain/entities/prescription_source.dart';
import 'package:osm/features/prescription/domain/failures/prescription_failure.dart';
import 'package:osm/features/prescription/domain/value_objects/eye_power.dart';
import 'package:osm/features/prescription/domain/value_objects/pupillary_distance.dart';

class Prescription {
  final PrescriptionId? id;
  final DateTime createdAt;
  final DateTime prescriptionDate;

  final EyePower rightEye;
  final EyePower leftEye;

  final PupillaryDistance? pd;
  final String? notes;

  final PrescriptionSource source;
  final DoctorId? doctorId;

  Prescription({
    required this.prescriptionDate,
    required this.source,
    this.id,
    required this.createdAt,
    required this.rightEye,
    required this.leftEye,
    this.pd,
    this.notes,
    this.doctorId,
  }) {
    _validate();
  }

  void _validate() {
    if (source == PrescriptionSource.external && doctorId == null) {
      throw PrescriptionValidationFailure("Doctor is required for external prescriptions.");
    }
  }
}

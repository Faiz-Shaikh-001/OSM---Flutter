import 'package:osm/core/value_objects/id.dart';

class Prescription {
  final PrescriptionId id;
  final DateTime createdAt;

  // Right eye
  final double sphereRight;
  final double cylinderRight;
  final int axisRight;
  final double? addRight;

  // Left eye
  final double sphereLeft;
  final double cylinderLeft;
  final int axisLeft;
  final double? addLeft;

  final double? pd;
  final String? notes;

  final CustomerId customerId;
  final DoctorId doctorId;

  Prescription({
    required this.id,
    required this.createdAt,
    required this.sphereRight,
    required this.cylinderRight,
    required this.axisRight,
    this.addRight,
    required this.sphereLeft,
    required this.cylinderLeft,
    required this.axisLeft,
    this.addLeft,
    this.pd,
    this.notes,
    required this.customerId,
    required this.doctorId,
  });
}


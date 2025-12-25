import 'package:osm/core/value_objects/id.dart';

abstract class PrescriptionSuccess {
  final String message;
  const PrescriptionSuccess(this.message);
}

class PrescriptionAddedSuccess extends PrescriptionSuccess {
  final PrescriptionId prescriptionId;
  const PrescriptionAddedSuccess(this.prescriptionId) : super("Prescription added successfully");
}

class PrescriptionDeletedSuccess extends PrescriptionSuccess {
  const PrescriptionDeletedSuccess() : super("Prescription deleted successfully");
}


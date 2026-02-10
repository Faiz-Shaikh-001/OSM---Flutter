import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/prescription/domain/entities/prescription.dart';

class PrescriptionWithDoctor {
  final Prescription prescription;
  final Doctor? doctor;

  PrescriptionWithDoctor(this.prescription, this.doctor);
}

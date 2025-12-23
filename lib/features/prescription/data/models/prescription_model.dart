import 'package:isar/isar.dart';
import 'package:osm/features/customer/data/models/customer_model.dart';
import 'package:osm/features/doctors/data/models/doctor_model.dart';

part 'prescription_model.g.dart';

@collection
class PrescriptionModel {
  Id id = Isar.autoIncrement;

  final DateTime createdAt;

  // ---- Right eye ----
  final double sphereRight;
  final double cylinderRight;
  final int axisRight;
  final double? addRight;

  // ---- Left eye ----
  final double sphereLeft;
  final double cylinderLeft;
  final int axisLeft;
  final double? addLeft;

  // Pupillary distance
  final double? pd;

  // Doctor notes
  final String? notes;

  // ---- Relations ----
  final IsarLink<CustomerModel> customer;
  final IsarLink<DoctorModel> doctor;

  PrescriptionModel({
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
    IsarLink<CustomerModel>? customer,
    IsarLink<DoctorModel>? doctor,
  })  : customer = customer ?? IsarLink<CustomerModel>(),
        doctor = doctor ?? IsarLink<DoctorModel>();
}

import 'package:isar/isar.dart';
import 'package:osm/data/models/customer_model.dart';
import 'package:osm/data/models/doctor_model.dart';
import 'package:osm/data/models/order_model.dart';

part 'prescription_model.g.dart';

@collection
class PrescriptionModel {
  Id id = Isar.autoIncrement;

  final DateTime prescriptionDate;

  final double sphereRight;
  final double cylinderRight;
  final double axisRight;

  final double sphereLeft;
  final double cylinderLeft;
  final double axisLeft;

  final double? addPower;
  final String? notes;

  // ---- RelationShips ----
  final customer = IsarLink<CustomerModel>();

  final doctor = IsarLink<DoctorModel>();

  @Backlink(to: 'prescription')
  final orders = IsarLinks<OrderModel>();

  PrescriptionModel({
    required this.prescriptionDate,
    required this.sphereRight,
    required this.cylinderRight,
    required this.axisRight,
    required this.sphereLeft,
    required this.cylinderLeft,
    required this.axisLeft,
    this.addPower,
    this.notes,
  });

  PrescriptionModel copyWith({
    Id? id,
    DateTime? prescriptionDate,
    double? sphereRight,
    double? cylinderRight,
    double? axisRight,
    double? sphereLeft,
    double? cylinderLeft,
    double? axisLeft,
    double? addPower,
    String? notes,
  }) {
    return PrescriptionModel(
      prescriptionDate: prescriptionDate ?? this.prescriptionDate,
      sphereRight: sphereRight ?? this.sphereRight,
      cylinderRight: cylinderRight ?? this.cylinderRight,
      axisRight: axisRight ?? this.axisRight,
      sphereLeft: sphereLeft ?? this.sphereLeft,
      cylinderLeft: cylinderLeft ?? this.cylinderLeft,
      axisLeft: axisLeft ?? this.axisLeft,
      addPower: addPower ?? this.addPower,
      notes: notes ?? this.notes,
    )..id = id ?? this.id;
  }
}

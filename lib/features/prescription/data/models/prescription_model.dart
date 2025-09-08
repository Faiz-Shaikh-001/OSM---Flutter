import 'package:isar/isar.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/doctors/data/models/doctor_model.dart';
import 'package:osm/features/orders/data/models/order_model.dart';

part 'prescription_model.g.dart';

@collection
class PrescriptionModel {
  Id id = Isar.autoIncrement;

  final DateTime prescriptionDate;

  final double sphereRight;
  final double cylinderRight;
  final double axisRight;
  final double? addRight;

  final double sphereLeft;
  final double cylinderLeft;
  final double axisLeft;
  final double? addLeft;

  final double? pd;
  final String? notes;

  // ---- RelationShips ----
  final IsarLink<CustomerModel> customer; // Initialized in constructor

  final IsarLink<DoctorModel> doctor; // Initialized in constructor

  @Backlink(to: 'prescription')
  final IsarLinks<OrderModel> orders; // Initialized in constructor

  PrescriptionModel({
    required this.prescriptionDate,
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
    IsarLinks<OrderModel>? orders,
  }) : customer = customer ?? IsarLink<CustomerModel>(),
       doctor = doctor ?? IsarLink<DoctorModel>(),
       orders = orders ?? IsarLinks<OrderModel>();

  PrescriptionModel copyWith({
    Id? id,
    DateTime? prescriptionDate,
    double? sphereRight,
    double? cylinderRight,
    double? axisRight,
    double? addRight,
    double? sphereLeft,
    double? cylinderLeft,
    double? axisLeft,
    double? addLeft,
    double? pd,
    String? notes,
    IsarLink<CustomerModel>? customer,
    IsarLink<DoctorModel>? doctor,
    IsarLinks<OrderModel>? orders,
  }) {
    return PrescriptionModel(
      prescriptionDate: prescriptionDate ?? this.prescriptionDate,
      sphereRight: sphereRight ?? this.sphereRight,
      cylinderRight: cylinderRight ?? this.cylinderRight,
      axisRight: axisRight ?? this.axisRight,
      addRight: addRight ?? this.addRight,
      sphereLeft: sphereLeft ?? this.sphereLeft,
      cylinderLeft: cylinderLeft ?? this.cylinderLeft,
      axisLeft: axisLeft ?? this.axisLeft,
      addLeft: addLeft ?? this.addLeft,
      pd: pd ?? this.pd,
      notes: notes ?? this.notes,
      customer: customer ?? this.customer,
      doctor: doctor ?? this.doctor,
      orders: orders ?? this.orders,
    )..id = id ?? this.id;
  }
}

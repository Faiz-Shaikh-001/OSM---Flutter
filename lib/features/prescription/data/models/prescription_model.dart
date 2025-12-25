import 'package:isar/isar.dart';
import 'package:osm/features/customer/data/models/customer_model.dart';
import 'package:osm/features/doctors/data/models/doctor_model.dart';
import 'package:osm/features/prescription/domain/entities/prescription_source.dart';

part 'prescription_model.g.dart';

@collection
class PrescriptionModel {
  Id id = Isar.autoIncrement;
  
  // ---- Metadata ----
  @Enumerated(EnumType.name)
  late PrescriptionSource source;

  @Index()
  late DateTime createdAt;
  late DateTime prescriptionDate;

  late double rightSphere;
  double? rightCylinder;
  int? rightAxis;
  double? rightAdd;

  late double leftSphere;
  double? leftCylinder;
  int? leftAxis;
  double? leftAdd;

  // Pupillary distance
  double? pdRight;
  double? pdLeft;

  // Doctor notes
  String? notes;

  // ---- Relations ----
  final IsarLink<CustomerModel> customer;
  final IsarLink<DoctorModel> doctor;

  PrescriptionModel({
    required this.createdAt,
    this.notes,
    IsarLink<CustomerModel>? customer,
    IsarLink<DoctorModel>? doctor,
  })  : customer = customer ?? IsarLink<CustomerModel>(),
        doctor = doctor ?? IsarLink<DoctorModel>();
}

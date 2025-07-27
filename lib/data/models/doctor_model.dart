import 'package:isar/isar.dart';
import 'package:osm/data/models/prescription_model.dart';
import 'package:osm/data/models/store_location_model.dart';

part 'doctor_model.g.dart';

@collection
class DoctorModel {
  Id id = Isar.autoIncrement;
  @Name('creationDate')
  DateTime? date;
  String designation;
  @Index(type: IndexType.hash)
  String doctorName;
  @Index(type: IndexType.value)
  String hospital;
  @Index(type: IndexType.value)
  String city;

  // --- Relationships ---
  @Backlink(to: 'doctor')
  final prescriptions = IsarLinks<PrescriptionModel>();

  final storeLocation = IsarLink<StoreLocationModel>();

  DoctorModel._internal({
    required this.date,
    required this.designation,
    required this.doctorName,
    required this.hospital,
    required this.city,
  });

  factory DoctorModel({
    DateTime? date,
    required String designation,
    required String doctorName,
    required String hospital,
    required String city,
  }) {
    return DoctorModel._internal(
      date: date ?? DateTime.now(),
      designation: designation,
      doctorName: doctorName,
      hospital: hospital,
      city: city,
    );
  }

  DoctorModel copyWith({
    Id? id,
    DateTime? date,
    String? designation,
    String? doctorName,
    String? hospital,
    String? city,
  }) {
    return DoctorModel(
      date: date ?? this.date,
      designation: designation ?? this.designation,
      doctorName: doctorName ?? this.doctorName,
      hospital: hospital ?? this.hospital,
      city: city ?? this.hospital,
    )..id = id ?? this.id;
  }
}

import 'package:isar/isar.dart';
import 'package:osm/features/prescription/data/models/prescription_model.dart';
import 'package:osm/features/store/data/model/store_location_model.dart';

part 'doctor_model.g.dart';

@collection
class DoctorModel {
  Id id = Isar.autoIncrement;

  final DateTime createdAt;

  final String designation;

  final bool isActive;

  @Index(type: IndexType.hash)
  final String name;

  @Index(type: IndexType.value)
  final String hospital;

  @Index(type: IndexType.value)
  final String city;

  // --- Relations ---
  @Backlink(to: 'doctor')
  final IsarLinks<PrescriptionModel> prescriptions;

  final IsarLink<StoreLocationModel> storeLocation;

  DoctorModel({
    required this.createdAt,
    required this.designation,
    required this.name,
    required this.hospital,
    required this.city,
    required this.isActive,
    IsarLinks<PrescriptionModel>? prescriptions,
    IsarLink<StoreLocationModel>? storeLocation,
  }) : prescriptions = prescriptions ?? IsarLinks<PrescriptionModel>(),
       storeLocation = storeLocation ?? IsarLink<StoreLocationModel>();
}

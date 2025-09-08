import 'package:isar/isar.dart';
import 'package:osm/features/prescription/data/models/prescription_model.dart';
import 'package:osm/features/inventory/data/models/store_location_model.dart';

part 'doctor_model.g.dart';

@collection
class DoctorModel {
  Id id = Isar.autoIncrement;
  @Name('creationDate')
  final DateTime? date; // Changed to final
  final String designation;
  @Index(type: IndexType.hash)
  final String doctorName; // Changed to final
  @Index(type: IndexType.value)
  final String hospital; // Changed to final
  @Index(type: IndexType.value)
  final String city; // Changed to final

  // --- Relationships ---
  @Backlink(to: 'doctor')
  final IsarLinks<PrescriptionModel> prescriptions; // Initialized in constructor

  final IsarLink<StoreLocationModel>
  storeLocation; // Initialized in constructor

  // Private constructor for internal use by the factory/copyWith
  DoctorModel._internal({
    this.date,
    required this.designation,
    required this.doctorName,
    required this.hospital,
    required this.city,
    IsarLinks<PrescriptionModel>? prescriptions,
    IsarLink<StoreLocationModel>? storeLocation,
  }) : prescriptions = prescriptions ?? IsarLinks<PrescriptionModel>(),
       storeLocation = storeLocation ?? IsarLink<StoreLocationModel>();

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
      prescriptions: IsarLinks<PrescriptionModel>(), // Pass new instances
      storeLocation: IsarLink<StoreLocationModel>(), // Pass new instances
    );
  }

  DoctorModel copyWith({
    Id? id,
    DateTime? date,
    String? designation,
    String? doctorName,
    String? hospital,
    String? city,
    IsarLinks<PrescriptionModel>? prescriptions,
    IsarLink<StoreLocationModel>? storeLocation,
  }) {
    return DoctorModel._internal(
      // Call internal constructor for copyWith
      date: date ?? this.date,
      designation: designation ?? this.designation,
      doctorName: doctorName ?? this.doctorName,
      hospital: hospital ?? this.hospital,
      city: city ?? this.city,
      prescriptions: prescriptions ?? this.prescriptions,
      storeLocation: storeLocation ?? this.storeLocation,
    )..id = id ?? this.id;
  }
}

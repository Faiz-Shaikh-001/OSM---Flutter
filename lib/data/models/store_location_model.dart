import 'package:isar/isar.dart';
import 'doctor_model.dart'; // For backlink
import 'order_model.dart'; // For backlink

part 'store_location_model.g.dart';

@Collection()
class StoreLocationModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  final String name;
  final String address;
  final String phoneNumber;
  final String operatingHours;

  // --- Relationships ---
  @Backlink(to: 'storeLocation')
  final doctors = IsarLinks<DoctorModel>();

  @Backlink(to: 'storeLocation')
  final orders = IsarLinks<OrderModel>();

  StoreLocationModel({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.operatingHours,
  });

  StoreLocationModel copyWith({
    Id? id,
    String? name,
    String? address,
    String? phoneNumber,
    String? operatingHours,
  }) {
    return StoreLocationModel(
      name: name ?? this.name,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      operatingHours: operatingHours ?? this.operatingHours,
    )..id = id ?? this.id;
  }
}

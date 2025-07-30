import 'package:isar/isar.dart';
import 'doctor_model.dart';
import 'order_model.dart';

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
  final IsarLinks<DoctorModel> doctors; // Initialized in constructor

  @Backlink(to: 'storeLocation')
  final IsarLinks<OrderModel> orders; // Initialized in constructor

  StoreLocationModel({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.operatingHours,
    IsarLinks<DoctorModel>? doctors, // Add to constructor
    IsarLinks<OrderModel>? orders, // Add to constructor
  }) : doctors = doctors ?? IsarLinks<DoctorModel>(),
       orders = orders ?? IsarLinks<OrderModel>();

  StoreLocationModel copyWith({
    Id? id,
    String? name,
    String? address,
    String? phoneNumber,
    String? operatingHours,
    IsarLinks<DoctorModel>? doctors,
    IsarLinks<OrderModel>? orders,
  }) {
    return StoreLocationModel(
      name: name ?? this.name,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      operatingHours: operatingHours ?? this.operatingHours,
      doctors: doctors ?? this.doctors,
      orders: orders ?? this.orders,
    )..id = id ?? this.id;
  }
}

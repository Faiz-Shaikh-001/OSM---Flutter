import 'package:isar/isar.dart';
import 'package:osm/features/orders/data/models/order/order_model.dart';
import 'package:osm/features/doctors/data/models/doctor_model.dart';

part 'store_location_model.g.dart';

@collection
class StoreLocationModel {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.hash)
  final String name;

  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String phoneNumber;
  final String operatingHours;

  final bool isActive;
  final DateTime createdAt;
  final String licenseNumber;

  // --- Relations ---
  @Backlink(to: 'storeLocation')
  final IsarLinks<OrderModel> orders;

  @Backlink(to: 'storeLocation')
  final IsarLinks<DoctorModel> doctors;

  final String? storeLogoUrl;

  StoreLocationModel({
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.phoneNumber,
    required this.operatingHours,
    this.isActive = true,
    required this.createdAt,
    required this.licenseNumber,
    this.storeLogoUrl,
    IsarLinks<OrderModel>? orders,
    IsarLinks<DoctorModel>? doctors,
  })  : orders = orders ?? IsarLinks<OrderModel>(),
        doctors = doctors ?? IsarLinks<DoctorModel>();
}

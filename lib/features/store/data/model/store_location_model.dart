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
  final String phoneNumber;
  final String operatingHours;

  final bool isActive;
  final DateTime createdAt;

  // --- Relations ---
  @Backlink(to: 'storeLocation')
  final IsarLinks<OrderModel> orders;

  @Backlink(to: 'storeLocation')
  final IsarLinks<DoctorModel> doctors;

  StoreLocationModel({
    required this.name,
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.operatingHours,
    this.isActive = true,
    required this.createdAt,
    IsarLinks<OrderModel>? orders,
    IsarLinks<DoctorModel>? doctors,
  })  : orders = orders ?? IsarLinks<OrderModel>(),
        doctors = doctors ?? IsarLinks<DoctorModel>();
}

import 'package:osm/core/value_objects/id.dart';

class StoreLocation {
  final StoreLocationId id;
  final String name;
  final String address;
  final String city;
  final String phoneNumber;
  final String operatingHours;
  final bool isActive;
  final DateTime createdAt;

  StoreLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.operatingHours,
    required this.isActive,
    required this.createdAt,
  });
}

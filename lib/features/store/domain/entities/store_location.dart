import 'package:osm/core/value_objects/id.dart';

class StoreLocation {
  final StoreLocationId? id;
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
  final String? storeLogoUrl;

  StoreLocation({
    this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.phoneNumber,
    required this.operatingHours,
    required this.isActive,
    required this.createdAt,
    required this.licenseNumber,
    this.storeLogoUrl
  });
}

import 'package:osm/core/value_objects/id.dart';

class Doctor {
  final DoctorId? id;
  final DateTime createdAt;
  final String name;
  final String designation;
  final String hospital;
  final String city;
  final bool isActive;
  final StoreLocationId storeLocationId;

  Doctor({
    this.id,
    required this.createdAt,
    required this.name,
    required this.designation,
    required this.hospital,
    required this.city,
    required this.isActive,
    required this.storeLocationId,
  });
}

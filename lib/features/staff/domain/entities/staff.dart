import 'package:osm/core/value_objects/id.dart';

class Staff {
  final StaffId? id;
  final String name;
  final String phone;
  final String email;
  final String role;
  final StoreLocationId storeId;
  final bool isActive;
  final DateTime createdAt;

  Staff({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.storeId,
    required this.isActive,
    required this.createdAt,
  });

  Staff copyWith({
    StaffId? id,
    String? name,
    String? phone,
    String? email,
    String? role,
    StoreLocationId? storeId,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Staff(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      role: role ?? this.role,
      storeId: storeId ?? this.storeId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
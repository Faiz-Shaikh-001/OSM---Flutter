import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/domain/entities/customer_type.dart';

class Customer {
  final CustomerId? id;

  final String firstName;
  final String lastName;

  final String primaryPhoneNumber;
  final String? secondaryPhoneNumber;
  final String? email;

  final DateTime? dateOfBirth;
  final Gender gender;

  final String? streetAddress;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;

  final CustomerType customerType;
  final List<String> tags;
  final String? notes;

  final DateTime createdAt;
  final DateTime? lastInteractionAt;
  final bool isActive;

  final String? profileImageUrl;

  const Customer({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.primaryPhoneNumber,
    this.secondaryPhoneNumber,
    this.email,
    this.dateOfBirth,
    required this.gender,
    this.streetAddress,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    required this.customerType,
    this.tags = const [],
    this.notes,
    required this.createdAt,
    this.lastInteractionAt,
    this.isActive = true,
    this.profileImageUrl,
  });

  String get fullName => '$firstName $lastName';

  int? get age {
    if (dateOfBirth == null) return null;
    final today = DateTime.now();
    var age = today.year - dateOfBirth!.year;
    if (today.month < dateOfBirth!.month ||
        (today.month == dateOfBirth!.month &&
            today.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }
}
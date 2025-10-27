import 'package:isar/isar.dart';
import '../../prescription/data/models/prescription_model.dart';
import '../../orders/data/models/order_model.dart';

part 'customer_model.g.dart';

@collection
class CustomerModel {
  Id id = Isar.autoIncrement;

  @Name('creationDate')
  final DateTime? dateCreated;

  @Index(type: IndexType.hash)
  final String firstName;

  @Index(type: IndexType.hash)
  final String lastName;

  final DateTime? dateOfBirth;
  final String gender;
  final int? age;

  // Contact Details
  @Index(unique: true)
  final String primaryPhoneNumber;
  final String? secondaryPhoneNumber;
  final String? email;

  // Address
  final String? streetAddress;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;

  // Additional Store Information
  @Enumerated(EnumType.name)
  final String? customerType;
  final String? notes;
  final DateTime? lastVisitDate;
  final String profileImageUrl;

  // ---- RelationShips ----
  @Backlink(to: 'customer')
  final IsarLinks<PrescriptionModel> prescriptions;

  @Backlink(to: 'customer')
  final IsarLinks<OrderModel> orders;

  CustomerModel._internal({
    this.dateCreated,
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
    this.gender = "Unknown",
    this.age,
    required this.primaryPhoneNumber,
    this.secondaryPhoneNumber,
    this.email,
    this.streetAddress,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.customerType,
    this.notes,
    this.lastVisitDate,
    required this.profileImageUrl,
    IsarLinks<PrescriptionModel>? prescriptions,
    IsarLinks<OrderModel>? orders,
  }) : prescriptions = prescriptions ?? IsarLinks<PrescriptionModel>(),
       orders = orders ?? IsarLinks<OrderModel>();

  // Factory constructor for creating new CustomerModel instances
  factory CustomerModel({
    DateTime? dateCreated,
    required String firstName,
    required String lastName,
    DateTime? dateOfBirth,
    String gender = "Unknown",
    int? age,
    required String primaryPhoneNumber,
    String? secondaryPhoneNumber,
    String? email,
    String? streetAddress,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    String? customerType,
    String? notes,
    DateTime? lastVisitDate,
    required String profileImageUrl,
  }) {
    return CustomerModel._internal(
      dateCreated: dateCreated ?? DateTime.now(),
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      gender: gender,
      age: age,
      primaryPhoneNumber: primaryPhoneNumber,
      secondaryPhoneNumber: secondaryPhoneNumber,
      email: email,
      streetAddress: streetAddress,
      city: city,
      state: state,
      postalCode: postalCode,
      country: country,
      customerType: customerType ?? 'Walk-In',
      notes: notes,
      lastVisitDate: lastVisitDate,
      profileImageUrl: profileImageUrl,
      prescriptions: IsarLinks<PrescriptionModel>(),
      orders: IsarLinks<OrderModel>(),
    );
  }

  // copyWith method for creating modified copies
  CustomerModel copyWith({
    Id? id,
    DateTime? dateCreated,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? gender,
    int? age,
    String? primaryPhoneNumber,
    String? secondaryPhoneNumber,
    String? email,
    String? streetAddress,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    String? customerType,
    String? notes,
    DateTime? lastVisitDate,
    String? profileImageUrl,
    IsarLinks<PrescriptionModel>? prescriptions,
    IsarLinks<OrderModel>? orders,
  }) {
    return CustomerModel._internal(
      dateCreated: dateCreated ?? this.dateCreated,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      primaryPhoneNumber: primaryPhoneNumber ?? this.primaryPhoneNumber,
      secondaryPhoneNumber: secondaryPhoneNumber ?? this.secondaryPhoneNumber,
      email: email ?? this.email,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      customerType: customerType ?? this.customerType,
      notes: notes ?? this.notes,
      lastVisitDate: lastVisitDate ?? this.lastVisitDate,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      prescriptions: prescriptions ?? this.prescriptions,
      orders: orders ?? this.orders,
    )..id = id ?? this.id;
  }
}

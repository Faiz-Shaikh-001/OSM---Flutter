import 'package:isar/isar.dart';
import 'prescription_model.dart';
import 'order_model.dart';

part 'customer_model.g.dart';

@collection
class CustomerModel {
  Id id = Isar.autoIncrement;
  @Name('creationDate')
  final DateTime? date;
  @Index(type: IndexType.hash)
  final String firstName;
  @Index(type: IndexType.hash)
  final String lastName;
  final String city;
  @Index(unique: true)
  final String primaryPhoneNumber;
  final String? secondaryPhoneNumber;
  final String? email;
  final String gender;
  final int age;
  final String profileImageUrl;

  // ---- RelationShips ----
  @Backlink(to: 'customer')
  final IsarLinks<PrescriptionModel> prescriptions;

  @Backlink(to: 'customer')
  final IsarLinks<OrderModel> orders;

  CustomerModel._internal({
    this.date,
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.primaryPhoneNumber,
    this.secondaryPhoneNumber,
    this.email,
    required this.gender,
    required this.age,
    required this.profileImageUrl,
    IsarLinks<PrescriptionModel>? prescriptions,
    IsarLinks<OrderModel>? orders,
  }) : prescriptions = prescriptions ?? IsarLinks<PrescriptionModel>(),
       orders = orders ?? IsarLinks<OrderModel>();

  // Factory constructor for creating new CustomerModel instances
  factory CustomerModel({
    DateTime? date,
    required String firstName,
    required String lastName,
    required String city,
    required String primaryPhoneNumber,
    String? secondaryPhoneNumber,
    String? email,
    required String gender,
    required int age,
    required String profileImageUrl,
  }) {
    return CustomerModel._internal(
      date: date ?? DateTime.now(),
      firstName: firstName,
      lastName: lastName,
      city: city,
      primaryPhoneNumber: primaryPhoneNumber,
      secondaryPhoneNumber: secondaryPhoneNumber,
      email: email,
      gender: gender,
      age: age,
      profileImageUrl: profileImageUrl,
      prescriptions: IsarLinks<PrescriptionModel>(),
      orders: IsarLinks<OrderModel>(),
    );
  }

  // copyWith method for creating modified copies
  CustomerModel copyWith({
    Id? id,
    DateTime? date,
    String? firstName,
    String? lastName,
    String? city,
    String? primaryPhoneNumber,
    String? secondaryPhoneNumber,
    String? email,
    String? gender,
    int? age,
    String? profileImageUrl,
    IsarLinks<PrescriptionModel>? prescriptions,
    IsarLinks<OrderModel>? orders,
  }) {
    return CustomerModel._internal(
      date: date ?? this.date,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      city: city ?? this.city,
      primaryPhoneNumber: primaryPhoneNumber ?? this.primaryPhoneNumber,
      secondaryPhoneNumber: secondaryPhoneNumber ?? this.secondaryPhoneNumber,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      prescriptions: prescriptions ?? this.prescriptions,
      orders: orders ?? orders,
    )..id = id ?? this.id;
  }
}

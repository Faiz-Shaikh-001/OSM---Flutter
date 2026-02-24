import 'package:isar/isar.dart';
import 'package:osm/features/customer/data/enums/customer_type_model.dart';
import 'package:osm/features/customer/data/enums/gender_model.dart';
import '../../../prescription/data/models/prescription_model.dart';
import '../../../orders/data/models/order/order_model.dart';

part 'customer_model.g.dart';

@collection
class CustomerModel {
  Id id = Isar.autoIncrement;

  // Customer Metadata
  final DateTime createdAt;
  DateTime? updatedAt;
  final bool isActive;

  // Identity
  @Index(type: IndexType.hash)
  final String firstName;

  @Index(type: IndexType.hash)
  final String lastName;

  final DateTime? dateOfBirth;

  @Enumerated(EnumType.name)
  final GenderModel gender;

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

  // Store Metadata
  @Enumerated(EnumType.name)
  final CustomerTypeModel customerType;
  final List<String> tags;
  final String? notes;
  final DateTime? lastInteractionAt;

  final String? profileImageUrl;

  // ---- Relations ----
  @Backlink(to: 'customer')
  final IsarLinks<PrescriptionModel> prescriptions;

  @Backlink(to: 'customer')
  final IsarLinks<OrderModel> orders;

  CustomerModel({
    required this.firstName,
    required this.lastName,
    required this.primaryPhoneNumber,

    required this.createdAt,
    this.updatedAt,
    this.isActive = true,

    this.dateOfBirth,
    required this.gender,

    this.secondaryPhoneNumber,
    this.email,

    this.streetAddress,
    this.city,
    this.state,
    this.postalCode,
    this.country,

    required this.customerType,
    this.tags = const [],
    this.notes,
    this.lastInteractionAt,

    this.profileImageUrl,

    IsarLinks<PrescriptionModel>? prescriptions,
    IsarLinks<OrderModel>? orders,
  }) : prescriptions = prescriptions ?? IsarLinks<PrescriptionModel>(),
       orders = orders ?? IsarLinks<OrderModel>();

  String get fullName => '$firstName $lastName';

  @override
  String toString() =>
      "Id: $id\nCustomer: $fullName\nPrimary Phone Number: $primaryPhoneNumber\nSecondary Phone Number: $secondaryPhoneNumber\nCreated At: $createdAt\nUpdated At: $updatedAt\nIs Active: $isActive\nDate Of Birth: $dateOfBirth\nGender: $gender\nEmail: $email\nStreet Address: $streetAddress\nCity: $city\nState: $state\n Postal Code: $postalCode\nCountry: $country\nCustomer Type: $customerType\n";
}

import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/data/mappers/customer_enum_mapper.dart';

import '../../domain/entities/customer.dart';
import '../models/customer_model.dart';

class CustomerMapper {
  static CustomerModel fromEntity(Customer customer) {
    return CustomerModel(
      createdAt: customer.createdAt,
      firstName: customer.firstName,
      lastName: customer.lastName,
      primaryPhoneNumber: customer.primaryPhoneNumber,
      secondaryPhoneNumber: customer.secondaryPhoneNumber,
      email: customer.email,
      dateOfBirth: customer.dateOfBirth,
      gender: CustomerEnumMapper.toGenderModel(customer.gender),
      streetAddress: customer.streetAddress,
      city: customer.city,
      state: customer.state,
      postalCode: customer.postalCode,
      country: customer.country,
      customerType: CustomerEnumMapper.toCustomerTypeModel(
        customer.customerType,
      ),
      tags: customer.tags,
      notes: customer.notes,
      lastInteractionAt: customer.lastInteractionAt,
      isActive: customer.isActive,
      profileImageUrl: customer.profileImageUrl,
    );
  }

  static Customer toEntity(CustomerModel model) {
    return Customer(
      id: CustomerId(model.id.toString()),
      firstName: model.firstName,
      lastName: model.lastName,
      primaryPhoneNumber: model.primaryPhoneNumber,
      secondaryPhoneNumber: model.secondaryPhoneNumber,
      email: model.email,
      dateOfBirth: model.dateOfBirth,
      gender: CustomerEnumMapper.toGender(model.gender),
      streetAddress: model.streetAddress,
      city: model.city,
      state: model.state,
      postalCode: model.postalCode,
      country: model.country,
      customerType: CustomerEnumMapper.toCustomerType(model.customerType),
      tags: model.tags,
      notes: model.notes,
      createdAt: model.createdAt,
      lastInteractionAt: model.lastInteractionAt,
      isActive: model.isActive,
      profileImageUrl: model.profileImageUrl,
    );
  }
}

// imports
import 'package:isar/isar.dart';
import 'package:flutter/material.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/dashboard/presentation/data/models/activity_repository.dart';
import 'package:osm/features/dashboard/presentation/data/models/recent_activities.dart';
import 'customer_model.dart';

class CustomerRepository {
  final IsarService _isarService;
  final ActivityRepository _activityRepository;
  CustomerRepository(this._isarService, this._activityRepository);

  Future<Id> add(CustomerModel customer) async {
    try {
      final isar = await _isarService.db;

      // Check if phone-number already exists
      final existing = await isar.customerModels
          .filter()
          .primaryPhoneNumberEqualTo(customer.primaryPhoneNumber)
          .findFirst();

      if (existing != null) {
        throw CustomerRepositoryException(
          "A customer with phone ${customer.primaryPhoneNumber} already exists",
        );
      }

      late Id newId;
      await isar.writeTxn(() async {
        newId = await isar.customerModels.put(customer);
        await _activityRepository.log(
          ActivityModel(
            type: ActivityType.newCustomerAdded,
            title: "New Customer: ${customer.firstName} ${customer.lastName}",
            subtitle: '',
            time: DateTime.now(),
          ),
          isar: isar,
        );
      });

      return newId;
    } catch (e) {
      debugPrint('Error adding customer: $e');
      throw CustomerRepositoryException(
        "Could not add customer ${customer.firstName} ${customer.lastName}",
      );
    }
  }

  // Updates an existing customer in the database.
  Future<void> update(CustomerModel customer) async {
    try {
      final isar = await _isarService.db;

      final existing = await isar.customerModels.get(customer.id);

      if (existing == null) {
        throw CustomerRepositoryException(
          "Cannot update customer. The record does not exists.",
        );
      }

      // Unique phone number check only if phone number changed
      if (customer.primaryPhoneNumber != existing.primaryPhoneNumber) {
        final phoneExist = await isar.customerModels
            .filter()
            .primaryPhoneNumberEqualTo(customer.primaryPhoneNumber)
            .findFirst();

        if (phoneExist != null) {
          throw CustomerRepositoryException(
            "Another customer already uses this phone number.",
          );
        }
      }

      await isar.writeTxn(() async {
        await isar.customerModels.put(customer);
        await _activityRepository.log(
          ActivityModel(
            type: ActivityType.customerUpdated,
            title: "Updated: ${customer.firstName} ${customer.lastName}",
            subtitle: "Phone: ${customer.primaryPhoneNumber}",
            time: DateTime.now(),
          ),
          isar: isar,
        );
      });
    } catch (e) {
      debugPrint('Error updating customer: $e');
      throw CustomerRepositoryException(
        "Failed to update customer (ID: ${customer.id}).",
      );
    }
  }

  // Deletes a customer by their ID.
  Future<bool> delete(Id id) async {
    try {
      final isar = await _isarService.db;

      final customer = await isar.customerModels.get(id);

      if (customer == null) {
        throw CustomerRepositoryException(
          "Customer with id $id doesn't exist.",
        );
      }

      // load relationships
      await customer.prescriptions.load();
      await customer.orders.load();

      if (customer.orders.isNotEmpty) {
        throw CustomerRepositoryException(
          "Cannot delete customer. They have active orders.",
        );
      }

      if (customer.prescriptions.isNotEmpty) {
        throw CustomerRepositoryException(
          "Cannot delete customer with prescription history.",
        );
      }

      bool deleted = false;
      await isar.writeTxn(() async {
        await _activityRepository.log(
          ActivityModel(
            type: ActivityType.customerDeleted,
            title:
                "Removed ${customer.firstName} ${customer.lastName} from database.",
            subtitle: "No related records",
            time: DateTime.now(),
          ),
          isar: isar,
        );
        deleted = await isar.customerModels.delete(id);
      });
      return deleted;
    } catch (e) {
      debugPrint("Delete error: $e");
      throw CustomerRepositoryException("Failed to delete customer (ID: $id).");
    }
  }

  // Retrieves all customer models from db
  Future<List<CustomerModel>> getAll() async {
    try {
      final isar = await _isarService.db;
      return isar.customerModels.where().findAll();
    } catch (e) {
      debugPrint("Error retrieving customer models: $e");
      rethrow;
    }
  }

  Stream<List<CustomerModel>> watchAll() async* {
    final isar = await _isarService.db;
    yield* isar.customerModels.where().watch(fireImmediately: true);
  }

  // Retrieve Customer by Id
  Future<CustomerModel?> getById(Id id) async {
    try {
      final isar = await _isarService.db;
      return isar.customerModels.get(id);
    } catch (e) {
      debugPrint("Error retrieving Customer by Id $id: $e");
      rethrow;
    }
  }

  // Retrieves a customer and eagerly loads their associated prescriptions and orders
  Future<CustomerModel?> getCustomerWithRelations(Id id) async {
    try {
      final isar = await _isarService.db;
      final customer = await isar.customerModels.get(id);

      if (customer != null) {
        await customer.prescriptions.load();
        await customer.orders.load();
      }
      return customer;
    } catch (e) {
      debugPrint("Error getting customer with relations by Id $id: $e");
      rethrow;
    }
  }

  // Searches customers by first name or last name.
  Future<List<CustomerModel>> searchCustomers(String query) async {
    try {
      final isar = await _isarService.db;
      final nameParts = query.trim().split(' ');

      final result = await isar.customerModels
          .filter()
          .optional(nameParts.length > 1, (q) {
            return q.group(
              (q2) => q2
                  .firstNameContains(nameParts.first, caseSensitive: false)
                  .and()
                  .lastNameContains(nameParts.last, caseSensitive: false),
            );
          })
          .or()
          .firstNameContains(query, caseSensitive: false)
          .or()
          .lastNameContains(query, caseSensitive: false)
          .or()
          .primaryPhoneNumberStartsWith(query)
          .findAll();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}

class CustomerRepositoryException implements Exception {
  final String message;
  CustomerRepositoryException(this.message);
  @override
  String toString() => message;
}

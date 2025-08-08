// imports
import 'package:isar/isar.dart';
import 'package:flutter/material.dart';
import 'package:osm/services/isar_service.dart';
import '../models/customer_model.dart';

class CustomerRepository {
  final IsarService _isarService;

  CustomerRepository(this._isarService);

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

  // Retrieves a customer and eagerly loads theri associated prescriptions and orders
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

  // Adds a new customer to the database.
  Future<Id> add(CustomerModel customer) async {
    try {
      final isar = await _isarService.db;
      late Id newId;
      await isar.writeTxn(() async {
        newId = await isar.customerModels.put(customer);
      });
      return newId;
    } catch (e) {
      debugPrint('Error adding customer: $e');
      rethrow;
    }
  }

  // Updates an existing customer in the database.
  Future<void> update(CustomerModel customer) async {
    try {
      final isar = await _isarService.db;
      await isar.writeTxn(() async {
        await isar.customerModels.put(customer);
      });
    } catch (e) {
      debugPrint('Error updating customer: $e');
      rethrow;
    }
  }

  // Deletes a customer by their ID.
  Future<bool> delete(Id id) async {
    try {
      final isar = await _isarService.db;
      late bool deleted;
      await isar.writeTxn(() async {
        deleted = await isar.customerModels.delete(id);
      });
      return deleted;
    } catch (e) {
      debugPrint('Error deleting customer: $e');
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
          .firstNameContains(query, caseSensitive: false)
          .or()
          .lastNameContains(query, caseSensitive: false)
          .or()
          .primaryPhoneNumberStartsWith(query)
          .findAll();
      debugPrint('Repository found ${result.length} customers.');
      return result;
    } catch (e) {
      debugPrint('Error searching customers: $e');
      rethrow;
    }
  }
}

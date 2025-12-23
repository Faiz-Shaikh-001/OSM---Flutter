import 'package:isar/isar.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/customer/data/models/customer_model.dart';

class CustomerLocalRepository {
  final IsarService _isarService;

  CustomerLocalRepository(this._isarService);

  Future<Id> insert(CustomerModel customer) async {
    final isar = await _isarService.db;

    return isar.customerModels.put(customer);
  }

  Future<void> update(CustomerModel customer) async {
    final isar = await _isarService.db;

    final existing = await isar.customerModels.get(customer.id);

    if (existing == null) {
      throw Exception("Customer does not exists.");
    }

    // Unique phone number check only if phone number changed
    if (customer.primaryPhoneNumber != existing.primaryPhoneNumber) {
      final phoneExist = await isar.customerModels
          .filter()
          .primaryPhoneNumberEqualTo(customer.primaryPhoneNumber)
          .findFirst();

      if (phoneExist != null) {
        throw Exception("Phone number already in use.");
      }
    }
    await isar.customerModels.put(customer);
  }

  Future<bool> delete(Id id) async {
    final isar = await _isarService.db;
    return isar.customerModels.delete(id);
  }

  Future<CustomerModel?> getById(Id id) async {
    final isar = await _isarService.db;
    return isar.customerModels.get(id);
  }

  Future<List<CustomerModel>> getAll() async {
    final isar = await _isarService.db;
    return isar.customerModels.where().findAll();
  }

  Stream<List<CustomerModel>> watchAll() async* {
    final isar = await _isarService.db;
    yield* isar.customerModels.where().watch(fireImmediately: true);
  }

  Future<CustomerModel?> getWithRelations(Id id) async {
    final isar = await _isarService.db;
    final customer = await isar.customerModels.get(id);

    if (customer != null) {
      await customer.prescriptions.load();
      await customer.orders.load();
    }

    return customer;
  }

  Future<List<CustomerModel>> search(String query) async {
    final isar = await _isarService.db;
    final parts = query.trim().split(' ');

    return isar.customerModels
        .filter()
        .optional(parts.length > 1, (q) {
          return q.group(
            (q2) => q2
                .firstNameContains(parts.first, caseSensitive: false)
                .and()
                .lastNameContains(parts.last, caseSensitive: false),
          );
        })
        .or()
        .firstNameContains(query, caseSensitive: false)
        .or()
        .lastNameContains(query, caseSensitive: false)
        .or()
        .primaryPhoneNumberStartsWith(query)
        .findAll();
  }
}

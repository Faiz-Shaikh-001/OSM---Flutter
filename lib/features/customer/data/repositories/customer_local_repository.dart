import 'package:isar/isar.dart';
import 'package:osm/features/customer/data/models/customer_model.dart';

class CustomerLocalRepository {
  CustomerLocalRepository();

  Future<Id> insert(CustomerModel customer, Isar isar) async {
    return isar.customerModels.put(customer);
  }

  Future<void> update(CustomerModel customer, Isar isar) async {
    await isar.customerModels.put(customer);
  }

  Future<bool> delete(Id id, Isar isar) async {
    return isar.customerModels.delete(id);
  }

  Future<CustomerModel?> getById(Id id, Isar isar) async {
    return isar.customerModels.get(id);
  }

  Future<List<CustomerModel>> getAll(Isar isar) async {
    return isar.customerModels.where().findAll();
  }

  Stream<List<CustomerModel>> watchAll(Isar isar) async* {
    yield* isar.customerModels.where().watch(fireImmediately: true);
  }

  Future<CustomerModel?> getWithRelations(Id id, Isar isar) async {
    final customer = await isar.customerModels.get(id);

    if (customer != null) {
      await customer.prescriptions.load();
      await customer.orders.load();
    }

    return customer;
  }

  Future<List<CustomerModel>> search(String query, Isar isar) async {
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

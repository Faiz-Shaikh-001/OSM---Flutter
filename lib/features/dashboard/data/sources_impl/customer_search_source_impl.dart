import 'package:isar/isar.dart';
import 'package:osm/features/customer/data/mappers/customer_mapper.dart';
import 'package:osm/features/customer/data/models/customer_model.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/dashboard/data/sources/customer_search_source.dart';

class CustomerSearchSourceImpl implements CustomerSearchSource {
  final Isar isar;

  CustomerSearchSourceImpl(this.isar);

  @override
  Future<List<Customer>> search(String query) async {
    final models = await isar.customerModels
        .filter()
        .group((q) => q
            .firstNameContains(query, caseSensitive: false)
            .or()
            .lastNameContains(query, caseSensitive: false)
            .or()
            .primaryPhoneNumberContains(query))
        .findAll();

    return models.map(CustomerMapper.toEntity).toList();
  }
}

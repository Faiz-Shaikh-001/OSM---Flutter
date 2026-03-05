import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/customer/data/mappers/customer_mapper.dart';
import 'package:osm/features/customer/data/repositories/customer_local_repository.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/dashboard/data/sources/customer_search_source.dart';

class CustomerSearchSourceImpl implements CustomerSearchSource {
  final IsarService _isarService;
  final CustomerLocalRepository _localRepository;

  CustomerSearchSourceImpl(this._isarService, this._localRepository);

  @override
  Future<List<Customer>> search(String query) async {
    final isar = await _isarService.db;
    final models = await _localRepository.search(query, isar);

    return models.map(CustomerMapper.toEntity).toList();
  }
}

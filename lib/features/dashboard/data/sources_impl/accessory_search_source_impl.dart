import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/dashboard/data/sources/accessory_search_source.dart';
import 'package:osm/features/inventory/data/mappers/accessory/accessory_mapper.dart';
import 'package:osm/features/inventory/data/repositories/accessory_local_repository.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';

class AccessorySearchSourceImpl implements AccessorySearchSource {
  final IsarService _isarService;
  final AccessoryLocalRepository _localRepository;

  AccessorySearchSourceImpl(this._isarService, this._localRepository);

  @override
  Future<List<Accessory>> search(String query) async {
    final isar = await _isarService.db;
    final models = await _localRepository.search(query, isar);

    return models.map(AccessoryMapper.toEntity).toList();
  }
}

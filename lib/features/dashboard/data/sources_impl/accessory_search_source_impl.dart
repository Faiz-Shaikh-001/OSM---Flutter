import 'package:isar/isar.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/dashboard/data/sources/accessory_search_source.dart';
import 'package:osm/features/inventory/data/mappers/accessory/accessory_mapper.dart';
import 'package:osm/features/inventory/data/models/accessory/accessory_model.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';

class AccessorySearchSourceImpl implements AccessorySearchSource {
  final IsarService _isarService;

  AccessorySearchSourceImpl(this._isarService);

  @override
  Future<List<Accessory>> search(String query) async {
    final isar = await _isarService.db;
    final models = await isar.accessoryModels
        .filter()
        .group((q) => q
            .nameContains(query, caseSensitive: false)
            .or()
            .brandContains(query, caseSensitive: false)
            .or()
            .categoryContains(query, caseSensitive: false)
            .or()
            .skuContains(query, caseSensitive: false))
        .findAll();

    return models.map(AccessoryMapper.toEntity).toList();
  }
}

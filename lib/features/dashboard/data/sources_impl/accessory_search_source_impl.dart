import 'package:isar/isar.dart';
import 'package:osm/features/dashboard/data/sources/accessory_search_source.dart';
import 'package:osm/features/inventory/data/mappers/accessory/accessory_mapper.dart';
import 'package:osm/features/inventory/data/models/accessory/accessory_model.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';

class AccessorySearchSourceImpl implements AccessorySearchSource {
  final Isar isar;

  AccessorySearchSourceImpl(this.isar);

  @override
  Future<List<Accessory>> search(String query) async {
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

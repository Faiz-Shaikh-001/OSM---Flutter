import 'package:isar/isar.dart';
import 'package:osm/features/dashboard/data/sources/lens_search_source.dart';
import 'package:osm/features/inventory/data/mappers/lens/lens_mapper.dart';
import 'package:osm/features/inventory/data/models/lens/lens_model.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';

class LensSearchSourceImpl implements LensSearchSource {
  final Isar isar;

  LensSearchSourceImpl(this.isar);

  @override
  Future<List<Lens>> search(String query) async {
    final models = await isar.lensModels
        .filter()
        .group((q) => q
            .productNameContains(query, caseSensitive: false)
            .or()
            .companyNameContains(query, caseSensitive: false))
        .findAll();

    return models.map(LensMapper.toEntity).toList();
  }
}

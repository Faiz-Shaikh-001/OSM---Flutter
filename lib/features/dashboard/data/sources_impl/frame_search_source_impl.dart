import 'package:isar/isar.dart';
import 'package:osm/features/dashboard/data/sources/frame_search_source.dart';
import 'package:osm/features/inventory/data/mappers/frame/frame_mapper.dart';
import 'package:osm/features/inventory/data/models/frame/frame_model.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';

class FrameSearchSourceImpl implements FrameSearchSource {
  final Isar isar;

  FrameSearchSourceImpl(this.isar);

  @override
  Future<List<Frame>> search(String query) async {
    final models = await isar.frameModels
        .filter()
        .group((q) => q
            .nameContains(query, caseSensitive: false)
            .or()
            .companyNameContains(query, caseSensitive: false))
        .findAll();

    return models.map(FrameMapper.toEntity).toList();
  }
}

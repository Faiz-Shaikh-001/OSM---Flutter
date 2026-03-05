import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/dashboard/data/sources/frame_search_source.dart';
import 'package:osm/features/inventory/data/mappers/frame/frame_mapper.dart';
import 'package:osm/features/inventory/data/repositories/frame_local_repository.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';

class FrameSearchSourceImpl implements FrameSearchSource {
  final IsarService _isarService;
  final FrameLocalRepository _localRepository;

  FrameSearchSourceImpl(this._isarService, this._localRepository);

  @override
  Future<List<Frame>> search(String query) async {
    final isar = await _isarService.db;
    final models = await _localRepository.search(query, isar);

    return models.map(FrameMapper.toEntity).toList();
  }
}

import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/dashboard/data/sources/lens_search_source.dart';
import 'package:osm/features/inventory/data/mappers/lens/lens_mapper.dart';
import 'package:osm/features/inventory/data/repositories/lens_local_repository.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';

class LensSearchSourceImpl implements LensSearchSource {
  final IsarService _isarService;

  final LensLocalRepository _localRepository;

  LensSearchSourceImpl(this._isarService, this._localRepository);

  @override
  Future<List<Lens>> search(String query) async {
    final isar = await _isarService.db;
    final models = await _localRepository.search(query, isar);

    return models.map(LensMapper.toEntity).toList();
  }
}

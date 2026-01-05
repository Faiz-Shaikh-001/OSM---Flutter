import 'package:isar/isar.dart';
import 'package:osm/core/services/isar_service.dart';
import '../entities/index_counter.dart';
import 'index_counter_repository.dart';

class IsarIndexCounterRepository implements IndexCounterRepository {
  final IsarService _isarService;

  IsarIndexCounterRepository(this._isarService);

  @override
  Future<int> next(String key) async {
    final isar = await _isarService.db;
    
    return await isar.writeTxn(() async {
      final existing = await isar.indexCounters
          .filter()
          .keyEqualTo(key)
          .findFirst();

      if (existing == null) {
        final counter = IndexCounter()
          ..key = key
          ..currentValue = 1;

        await isar.indexCounters.put(counter);
        return 1;
      }

      existing.currentValue += 1;
      await isar.indexCounters.put(existing);
      return existing.currentValue;
    });
  }
}

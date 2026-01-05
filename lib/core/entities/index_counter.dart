import 'package:isar/isar.dart';

part 'index_counter.g.dart';

@collection
class IndexCounter {
  Id id = Isar.autoIncrement;

  // Canonical key (e.g. FRAMEVARIANT_RAY_RECT)
  @Index(unique: true)
  late String key;

  // Last used sequence number
  int currentValue = 0;
}

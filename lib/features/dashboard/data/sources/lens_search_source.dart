import 'package:osm/features/inventory/domain/entities/lens/lens.dart';

abstract class LensSearchSource {
  Future<List<Lens>> search(String query);
}
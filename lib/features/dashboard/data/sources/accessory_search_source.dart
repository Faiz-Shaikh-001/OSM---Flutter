import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';

abstract class AccessorySearchSource {
  Future<List<Accessory>> search(String query);
}

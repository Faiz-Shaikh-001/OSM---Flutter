import 'package:isar/isar.dart';

part 'active_store_model.g.dart';

@collection
class ActiveStoreModel {
  Id id = 1; // singleton row

  final int storeLocationId;

  ActiveStoreModel({
    required this.storeLocationId,
  });
}

import 'package:isar/isar.dart';
import 'package:osm/features/store/data/model/active_store_model.dart';
import 'package:osm/features/store/data/model/store_location_model.dart';

class StoreLocationLocalRepository {
  const StoreLocationLocalRepository();

  Future<List<StoreLocationModel>> getAll(Isar isar) async {
    return await isar.storeLocationModels.where().findAll();
  }

  Future<StoreLocationModel?> getById(int id, Isar isar) async {
    return await isar.storeLocationModels.get(id);
  }

  Future<ActiveStoreModel?> getActive(int id, Isar isar) async {
    return await isar.activeStoreModels.get(id);
  }

  Future<int> setActive(ActiveStoreModel model, Isar isar) async {
    return await isar.activeStoreModels.put(model);
  }

  Future<int> insert(StoreLocationModel model, Isar isar) async {
    return await isar.storeLocationModels.put(model);
  }

  Future<bool> delete(int id, Isar isar) async {
    return await isar.storeLocationModels.delete(id);
  }
}
import 'package:isar/isar.dart';
import 'package:osm/features/inventory/data/models/accessory/accessory_model.dart';

class AccessoryLocalRepository {
  AccessoryLocalRepository();

  Future<List<AccessoryModel>> getAll(Isar isar) async {
    return await isar.accessoryModels.where().findAll();
  }

  Future<AccessoryModel?> getById(int id, Isar isar) async {
    return await isar.accessoryModels.get(id);
  }

  Future<List<AccessoryModel>> getByBrand(String brand, Isar isar) async {
    return await isar.accessoryModels
        .filter()
        .brandEqualTo(brand, caseSensitive: false)
        .findAll();
  }

  Future<List<AccessoryModel>> getByName(String name, Isar isar) async {
    return await isar.accessoryModels
        .filter()
        .nameEqualTo(name, caseSensitive: false)
        .findAll();
  }

  Future<int> insert(AccessoryModel model, Isar isar) async {
    return await isar.accessoryModels.put(model);
  }

  Future<bool> delete(int id, Isar isar) async {
    return await isar.accessoryModels.delete(id);
  }

  Future<AccessoryModel?> getByQrKey(String qrKey, Isar isar) async {
    return await isar.accessoryModels.filter().qrKeyEqualTo(qrKey).findFirst();
  }
}

import 'package:isar/isar.dart';
import 'package:osm/features/inventory/data/enums/lens_type_model.dart';
import 'package:osm/features/inventory/data/models/lens/lens_model.dart';

class LensLocalRepository {
  LensLocalRepository();

  Future<List<LensModel>> getAll(Isar isar) async {
    return await isar.lensModels.where().findAll();
  }

  Future<LensModel?> getById(int id, Isar isar) async {
    return await isar.lensModels.get(id);
  }

  Future<List<LensModel>> getByCompany(String companyName, Isar isar) async {
    return await isar.lensModels
        .filter()
        .companyNameEqualTo(companyName)
        .findAll();
  }

  Future<List<LensModel>> getByProductName(
    String productName,
    Isar isar,
  ) async {
    return await isar.lensModels
        .filter()
        .productNameEqualTo(productName)
        .findAll();
  }

  Future<List<LensModel>> getByType(LensTypeModel type, Isar isar) async {
    return await isar.lensModels.filter().lensTypeEqualTo(type).findAll();
  }

  Future<int> insert(LensModel model, Isar isar) async {
    return await isar.lensModels.put(model);
  }

  Future<int> update(LensModel model, Isar isar) async {
    return await isar.lensModels.put(model);
  }

  Future<bool> delete(int id, Isar isar) async {
    return await isar.lensModels.delete(id);
  }

  Future<LensModel?> getByQrKey(String qrKey, Isar isar) async {
    return await isar.lensModels.filter().qrKeyEqualTo(qrKey).findFirst();
  }

  Future<List<LensModel>> search(String query, Isar isar) async {
    return await isar.lensModels
        .filter()
        .group(
          (q) => q
              .productNameContains(query, caseSensitive: false)
              .or()
              .companyNameContains(query, caseSensitive: false),
        )
        .findAll();
  }
}

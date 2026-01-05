import 'package:isar/isar.dart';
import 'package:osm/features/inventory/data/enums/frame_type_model.dart';
import 'package:osm/features/inventory/data/models/frame/frame_model.dart';

class FrameLocalRepository {
  FrameLocalRepository();

  Future<int> insert(FrameModel model, Isar isar) async {
    return await isar.frameModels.put(model);
  }

  Future<int> update(FrameModel model, Isar isar) async {
    return await isar.frameModels.put(model);
  }

  Future<bool> delete(int id, Isar isar) async {
    return await isar.frameModels.delete(id);
  }

  Future<FrameModel?> getById(int id, Isar isar) async {
    return await isar.frameModels.get(id);
  }

  Future<List<FrameModel>> getAll(Isar isar) async {
    return await isar.frameModels.where().findAll();
  }

  Future<List<FrameModel>> getByCompany(String companyName, Isar isar) async {
    return await isar.frameModels
        .filter()
        .companyNameEqualTo(companyName, caseSensitive: false)
        .findAll();
  }

  Future<List<FrameModel>> getByName(String name, Isar isar) async {
    return await isar.frameModels
        .filter()
        .nameContains(name, caseSensitive: false)
        .findAll();
  }

  Future<List<FrameModel>> getByType(FrameTypeModel type, Isar isar) async {
    return await isar.frameModels.filter().frameTypeEqualTo(type).findAll();
  }

  Future<FrameModel?> getByQrKey(String qrKey, Isar isar) async {
    return await isar.frameModels
        .filter()
        .qrKeyEqualTo(qrKey)
        .findFirst();
  }
}

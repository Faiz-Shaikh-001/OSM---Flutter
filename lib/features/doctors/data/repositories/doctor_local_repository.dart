import 'package:isar/isar.dart';
import 'package:osm/features/doctors/data/models/doctor_model.dart';
import 'package:osm/features/store/data/model/store_location_model.dart';

class DoctorLocalRepository {
  const DoctorLocalRepository();

  Future<int> insert(DoctorModel model, Isar isar) async {
    return await isar.doctorModels.put(model);
  }

  Future<DoctorModel?> getById(int id, Isar isar) async {
    return await isar.doctorModels.get(id);
  }

  Future<List<DoctorModel>> getAll(Isar isar) async {
    return await isar.doctorModels.where().findAll();
  }

  Future<List<DoctorModel>> getByStoreLocation(
    int locationId,
    Isar isar,
  ) async {
    return await isar.doctorModels
        .filter()
        .storeLocation((s) => s.idEqualTo(locationId))
        .findAll();
  }

}

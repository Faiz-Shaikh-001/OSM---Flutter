import 'package:isar/isar.dart';
import 'package:osm/features/dashboard/data/sources/doctor_search_source.dart';
import 'package:osm/features/doctors/data/mapper/doctor_mapper.dart';
import 'package:osm/features/doctors/data/models/doctor_model.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';

class DoctorSearchSourceImpl implements DoctorSearchSource {
  final Isar isar;

  DoctorSearchSourceImpl(this.isar);

  @override
  Future<List<Doctor>> search(String query) async {
    final models = await isar.doctorModels
        .filter()
        .group((q) => q
            .nameContains(query, caseSensitive: false)
            .or()
            .hospitalContains(query, caseSensitive: false)
            .or()
            .cityContains(query, caseSensitive: false))
        .findAll();

    return models.map(DoctorMapper.toEntity).toList();
  }
}

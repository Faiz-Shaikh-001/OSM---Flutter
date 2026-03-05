import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/dashboard/data/sources/doctor_search_source.dart';
import 'package:osm/features/doctors/data/mapper/doctor_mapper.dart';
import 'package:osm/features/doctors/data/repositories/doctor_local_repository.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';

class DoctorSearchSourceImpl implements DoctorSearchSource {
  final IsarService _isarService;
  final DoctorLocalRepository _localRepository;

  DoctorSearchSourceImpl(this._isarService, this._localRepository);

  @override
  Future<List<Doctor>> search(String query) async {
    final isar = await _isarService.db;

    final models = await _localRepository.search(query, isar);

    return models.map(DoctorMapper.toEntity).toList();
  }
}

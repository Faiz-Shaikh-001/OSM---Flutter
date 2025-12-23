import 'package:osm/features/doctors/domain/entities/doctor.dart';

abstract class DoctorSearchSource {
  Future<List<Doctor>> search(String query);
}
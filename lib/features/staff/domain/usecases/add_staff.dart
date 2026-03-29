import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/staff/domain/entities/staff.dart';
import 'package:osm/features/staff/domain/repositories/staff_repository.dart';

class AddStaff {
  final StaffRepository repository;

  AddStaff(this.repository);

  Future<Either<String, StaffId>> call(Staff staff) {
    return repository.add(staff);
  }
}
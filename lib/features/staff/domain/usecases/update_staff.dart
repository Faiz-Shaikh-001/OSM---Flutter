import 'package:osm/core/either.dart';
import 'package:osm/features/staff/domain/entities/staff.dart';
import 'package:osm/features/staff/domain/repositories/staff_repository.dart';

class UpdateStaff {
  final StaffRepository repository;

  UpdateStaff(this.repository);

  Future<Either<String, void>> call(Staff staff) {
    return repository.update(staff);
  }
}
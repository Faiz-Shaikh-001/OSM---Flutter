import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/staff/domain/repositories/staff_repository.dart';

class DeleteStaff {
  final StaffRepository repository;

  DeleteStaff(this.repository);

  Future<Either<String, void>> call(StaffId id) {
    return repository.delete(id);
  }
}
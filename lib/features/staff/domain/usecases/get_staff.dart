import 'package:osm/core/either.dart';
import 'package:osm/features/staff/domain/entities/staff.dart';
import 'package:osm/features/staff/domain/repositories/staff_repository.dart';

class GetStaff {
  final StaffRepository repository;

  GetStaff(this.repository);

  Future<Either<String, List<Staff>>> call() {
    return repository.getAll();
  }
}
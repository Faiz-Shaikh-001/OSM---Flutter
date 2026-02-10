import 'package:osm/core/either.dart';
import '../../entities/accessory/accessory.dart';
import '../../failures/accessory/accessory_failure.dart';
import '../../repositories/accessory_repository.dart';

class GetAccessoriesByName {
  final AccessoryRepository repository;

  GetAccessoriesByName(this.repository);

  Future<Either<AccessoryFailure, List<Accessory>>> call(String name) {
    return repository.getByName(name);
  }
}

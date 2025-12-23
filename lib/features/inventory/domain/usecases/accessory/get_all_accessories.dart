import 'package:osm/core/either.dart';
import '../../entities/accessory/accessory.dart';
import '../../failures/accessory/accessory_failure.dart';
import '../../repositories/accessory_repository.dart';

class GetAllAccessories {
  final AccessoryRepository repository;

  GetAllAccessories(this.repository);

  Future<Either<AccessoryFailure, List<Accessory>>> call() {
    return repository.getAll();
  }
}

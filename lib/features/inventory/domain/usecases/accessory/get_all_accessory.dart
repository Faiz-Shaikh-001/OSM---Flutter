import 'package:osm/core/either.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/domain/failures/accessory/accessory_failure.dart';
import 'package:osm/features/inventory/domain/repositories/accessory_repository.dart';

class GetAllAccessories {
  final AccessoryRepository repository;

  GetAllAccessories(this.repository);

  Future<Either<AccessoryFailure, List<Accessory>>> call() {
    return repository.getAll();
  }
}

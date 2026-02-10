import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import '../../entities/accessory/accessory.dart';
import '../../failures/accessory/accessory_failure.dart';
import '../../repositories/accessory_repository.dart';

class GetAccessoryById {
  final AccessoryRepository repository;

  GetAccessoryById(this.repository);

  Future<Either<AccessoryFailure, Accessory>> call(
    AccessoryId id,
  ) {
    return repository.getById(id);
  }
}

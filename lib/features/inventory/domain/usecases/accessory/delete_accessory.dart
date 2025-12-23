import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/failures/accessory/accessory_failure.dart';
import 'package:osm/features/inventory/domain/repositories/accessory_repository.dart';
import 'package:osm/features/inventory/domain/success/accessory/accessory_success.dart';

class DeleteAccessory {
  final AccessoryRepository repository;

  DeleteAccessory(this.repository);

  Future<Either<AccessoryFailure, AccessoryDeletedSuccess>> call(
    AccessoryId id,
  ) {
    return repository.delete(id);
  }
}

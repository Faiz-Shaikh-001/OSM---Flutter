import 'package:osm/core/either.dart';
import '../../entities/accessory/accessory.dart';
import '../../failures/accessory/accessory_failure.dart';
import '../../repositories/accessory_repository.dart';
import '../../success/accessory/accessory_success.dart';

class UpdateAccessory {
  final AccessoryRepository repository;

  UpdateAccessory(this.repository);

  Future<Either<AccessoryFailure, AccessoryUpdatedSuccess>> call(
    Accessory accessory,
  ) async {
    if (accessory.id.value.isEmpty) {
      return const Left(
        AccessoryValidationFailure('Accessory ID is required'),
      );
    }

    if (accessory.name.trim().isEmpty) {
      return const Left(
        AccessoryValidationFailure('Accessory name is required'),
      );
    }

    return repository.update(accessory);
  }
}

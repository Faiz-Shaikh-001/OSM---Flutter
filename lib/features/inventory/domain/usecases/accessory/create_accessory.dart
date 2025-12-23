import 'package:osm/core/either.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/domain/failures/accessory/accessory_failure.dart';
import 'package:osm/features/inventory/domain/repositories/accessory_repository.dart';
import 'package:osm/features/inventory/domain/success/accessory/accessory_success.dart';

class CreateAccessory {
  final AccessoryRepository repository;

  CreateAccessory(this.repository);

  Future<Either<AccessoryFailure, AccessoryCreatedSuccess>> call(
    Accessory accessory,
  ) async {
    if (accessory.name.isEmpty) {
      return const Left(
        AccessoryValidationFailure('Accessory name is required'),
      );
    }

    if (accessory.salesPrice.value <= 0) {
      return const Left(
        AccessoryValidationFailure('Invalid sales price'),
      );
    }

    return repository.create(accessory);
  }
}

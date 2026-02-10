import 'package:osm/core/either.dart';
import 'package:osm/core/repositories/index_counter_repository.dart';
import 'package:osm/core/utils/counter_key.dart';
import 'package:osm/core/utils/sku_generator.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/domain/failures/accessory/accessory_failure.dart';
import 'package:osm/features/inventory/domain/repositories/accessory_repository.dart';
import 'package:osm/features/inventory/domain/success/accessory/accessory_success.dart';
import 'package:osm/features/inventory/presentation/dto/create_accessory_input.dart';

class CreateAccessory {
  final AccessoryRepository repository;
  final IndexCounterRepository counterRepository;

  CreateAccessory(this.repository, this.counterRepository);

  Future<Either<AccessoryFailure, AccessoryCreatedSuccess>> call(
    CreateAccessoryInput input,
  ) async {
    if (input.name.isEmpty) {
      return const Left(
        AccessoryValidationFailure('Accessory name is required'),
      );
    }

    if (input.salesPrice.value <= 0) {
      return const Left(AccessoryValidationFailure('Invalid sales price'));
    }

    final counterKey = CounterKey.accessory(
      brand: input.brand,
      category: input.category,
    );

    final seq = await counterRepository.next(counterKey);

    final sku = SkuGenerator.accessorySku(
      brand: input.brand,
      category: input.category,
      sequence: seq,
    );

    final accessory = Accessory(
      qrKey: input.qrKey,
      createdAt: DateTime.now(),
      category: input.category,
      brand: input.brand,
      name: input.name,
      sku: sku,
      quantity: input.quantity,
      purchasePrice: input.purchasePrice,
      salesPrice: input.salesPrice,
      imageUrls: input.imageUrls,
      isActive: input.isActive,
      description: input.description,
    );

    return repository.create(accessory);
  }
}

import 'package:osm/core/either.dart';
import '../../entities/accessory/accessory.dart';
import '../../failures/accessory/accessory_failure.dart';
import '../../repositories/accessory_repository.dart';

class GetAccessoriesByBrand {
  final AccessoryRepository repository;

  GetAccessoriesByBrand(this.repository);

  Future<Either<AccessoryFailure, List<Accessory>>> call(String brand) {
    return repository.getByBrand(brand);
  }
}

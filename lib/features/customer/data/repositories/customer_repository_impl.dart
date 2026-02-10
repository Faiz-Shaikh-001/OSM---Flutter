import 'package:isar/isar.dart';
import 'package:osm/core/either.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/customer/data/mappers/customer_mapper.dart';
import 'package:osm/features/customer/data/models/customer_model.dart';
import 'package:osm/features/customer/data/repositories/customer_local_repository.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/domain/failures/customer_failure.dart';
import 'package:osm/features/customer/domain/repositories/customer_repository.dart';
import 'package:osm/features/customer/domain/success/customer_success.dart';
import 'package:osm/features/dashboard/data/repositories/activity_local_repository.dart';
import 'package:osm/features/dashboard/domain/entities/activity.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final IsarService _isarService;
  final CustomerLocalRepository _localRepository;
  final ActivityLocalRepository _activityRepository;

  CustomerRepositoryImpl({
    required IsarService isarService,
    required CustomerLocalRepository localRepository,
    required ActivityLocalRepository activityRepository,
  }) : _isarService = isarService,
       _localRepository = localRepository,
       _activityRepository = activityRepository;

  // ADD
  @override
  Future<Either<CustomerFailure, CustomerId>> add(Customer customer) async {
    final isar = await _isarService.db;
    final existing = await isar.customerModels
        .filter()
        .primaryPhoneNumberEqualTo(customer.primaryPhoneNumber)
        .findFirst();

    if (existing != null) {
      return const Left(CustomerDuplicatePhoneFailure());
    }

    final id = await isar.writeTxn(() async {
      return await _localRepository.insert(
        CustomerMapper.fromEntity(customer),
        isar,
      );
    });

    await isar.writeTxn(() async {
      await _activityRepository.log(
        Activity(
          type: ActivityType.newCustomerAdded,
          occurredAt: DateTime.now(),
          metadata: {'customerId': id, 'name': customer.fullName},
        ),
        isar: isar,
      );
    });

    return Right(CustomerId(id.toString()));
  }

  // Update
  @override
  Future<Either<CustomerFailure, Customer>> update(Customer customer) async {
    try {
      if (customer.id == null) {
        return const Left(CustomerValidationFailure('Missing customer ID'));
      }

      final isar = await _isarService.db;

      final model = CustomerMapper.fromEntity(customer)
        ..id = int.parse(customer.id!.value);

      final existing = await isar.customerModels.get(model.id);

      if (existing == null) {
        return Left(CustomerNotFoundFailure());
      }

      if (customer.primaryPhoneNumber != existing.primaryPhoneNumber) {
        final phoneExist = await isar.customerModels
            .filter()
            .primaryPhoneNumberEqualTo(customer.primaryPhoneNumber)
            .findFirst();

        if (phoneExist != null) {
          throw Exception("Phone number already in use.");
        }
      }

      await isar.writeTxn(() async {
        await _localRepository.update(model, isar);
        await _activityRepository.log(
          Activity(
            type: ActivityType.customerUpdated,
            occurredAt: DateTime.now(),
            metadata: {'customerId': customer.id, 'name': customer.fullName},
          ),
          isar: isar,
        );
      });

      return Right(customer);
    } catch (e) {
      return const Left(CustomerUnknownFailure());
    }
  }

  // Delete
  @override
  Future<Either<CustomerFailure, CustomerSuccess>> delete(CustomerId id) async {
    try {
      final isar = await _isarService.db;
      final parsedId = int.parse(id.value);

      final model = await _localRepository.getById(parsedId, isar);

      if (model == null) {
        throw const CustomerNotFoundFailure();
      }

      await model.orders.load();
      await model.prescriptions.load();

      if (model.orders.isNotEmpty || model.prescriptions.isNotEmpty) {
        throw const CustomerHasRelationsFailure();
      }

      await isar.writeTxn(() async {
        await _localRepository.delete(parsedId, isar);

        await _activityRepository.log(
          Activity(
            type: ActivityType.customerDeleted,
            occurredAt: DateTime.now(),
            metadata: {'customerId': id.value, 'name': model.fullName},
          ),
          isar: isar,
        );
      });

      return const Right(CustomerDeletedSuccess());
    } catch (e) {
      if (e is CustomerFailure) return Left(e);
      return const Left(CustomerUnknownFailure());
    }
  }

  // Read
  @override
  Future<Either<CustomerFailure, Customer>> getById(CustomerId id) async {
    try {
      final isar = await _isarService.db;
      final model = await _localRepository.getById(int.parse(id.value), isar);

      if (model == null) {
        return const Left(CustomerNotFoundFailure());
      }

      final customer = CustomerMapper.toEntity(model);
      return Right(customer);
    } catch (e) {
      return const Left(CustomerUnknownFailure());
    }
  }

  @override
  Future<Either<CustomerFailure, List<Customer>>> getAll() async {
    try {
      final isar = await _isarService.db;
      final models = await _localRepository.getAll(isar);
      return Right(models.map(CustomerMapper.toEntity).toList());
    } catch (_) {
      return const Left(CustomerUnknownFailure());
    }
  }

  @override
  Stream<Either<CustomerFailure, List<Customer>>> watchAll() async* {
    try {
      final isar = await _isarService.db;
      yield* _localRepository.watchAll(isar).map(
        (models) => Right(models.map(CustomerMapper.toEntity).toList()),
      );
    } catch (e) {
      yield const Left(CustomerUnknownFailure());
    }
  }

  // Search
  @override
  Future<Either<CustomerFailure, List<Customer>>> search(String query) async {
    try {
      final isar = await _isarService.db;
      final models = await _localRepository.search(query, isar);
      return Right(models.map(CustomerMapper.toEntity).toList());
    } catch (_) {
      return const Left(CustomerUnknownFailure());
    }
  }
}

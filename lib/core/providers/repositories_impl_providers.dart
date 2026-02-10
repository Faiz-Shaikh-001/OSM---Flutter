import 'package:osm/core/repositories/index_counter_repository.dart';
import 'package:osm/core/repositories/isar_index_counter_repository.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/customer/data/repositories/customer_local_repository.dart';
import 'package:osm/features/customer/data/repositories/customer_repository_impl.dart';
import 'package:osm/features/customer/domain/repositories/customer_repository.dart';
import 'package:osm/features/dashboard/data/repositories/activity_local_repository.dart';
import 'package:osm/features/dashboard/data/repositories/activity_repository_impl.dart';
import 'package:osm/features/dashboard/domain/repositories/activity_repository.dart';
import 'package:osm/features/doctors/data/repositories/doctor_local_repository.dart';
import 'package:osm/features/doctors/data/repositories/doctor_repository_impl.dart';
import 'package:osm/features/doctors/domain/repositories/doctor_repository.dart';
import 'package:osm/features/inventory/data/repositories/accessory_local_repository.dart';
import 'package:osm/features/inventory/data/repositories/accessory_repository_impl.dart';
import 'package:osm/features/inventory/data/repositories/frame_local_repository.dart';
import 'package:osm/features/inventory/data/repositories/frame_repository_impl.dart';
import 'package:osm/features/inventory/data/repositories/lens_local_repository.dart';
import 'package:osm/features/inventory/data/repositories/lens_repository_impl.dart';
import 'package:osm/features/inventory/domain/repositories/accessory_repository.dart';
import 'package:osm/features/inventory/domain/repositories/frame_repository.dart';
import 'package:osm/features/inventory/domain/repositories/lens_repository.dart';
import 'package:osm/features/orders/data/repositories/order_item_local_repository.dart';
import 'package:osm/features/orders/data/repositories/order_local_repository.dart';
import 'package:osm/features/orders/data/repositories/order_repository_impl.dart';
import 'package:osm/features/orders/data/repositories/payment_local_repository.dart';
import 'package:osm/features/orders/domain/repositories/order_repository.dart';
import 'package:osm/features/prescription/data/repositories/prescription_local_repository.dart';
import 'package:osm/features/prescription/data/repositories/prescription_repository_impl.dart';
import 'package:osm/features/prescription/domain/repositories/prescription_repository.dart';
import 'package:osm/features/store/data/repositories/store_location_local_repository.dart';
import 'package:osm/features/store/data/repositories/store_location_repository_impl.dart';
import 'package:osm/features/store/domain/repositories/store_location_repository.dart';
import 'package:provider/provider.dart';

final List<Provider> repositoryImplProviders = [
  // RepositoryImpl
  Provider<StoreLocationRepository>(
    create: (context) => StoreLocationRepositoryImpl(
      context.read<IsarService>(),
      context.read<StoreLocationLocalRepository>(),
    ),
  ),

  Provider<ActivityRepository>(
    create: (context) => ActivityRepositoryImpl(
      context.read<IsarService>(),
      context.read<ActivityLocalRepository>(),
    ),
  ),

  Provider<OrderRepository>(
    create: (context) => OrderRepositoryImpl(
      context.read<IsarService>(),
      context.read<OrderLocalRepository>(),
      context.read<PaymentLocalRepository>(),
      context.read<CustomerLocalRepository>(),
      context.read<StoreLocationLocalRepository>(),
      context.read<PrescriptionLocalRepository>(),
      context.read<OrderItemLocalRepository>(),
    ),
  ),

  Provider<DoctorRepository>(
    create: (context) => DoctorRepositoryImpl(
      context.read<IsarService>(),
      context.read<DoctorLocalRepository>(),
      context.read<StoreLocationLocalRepository>(),
    ),
  ),

  Provider<PrescriptionRepository>(
    create: (context) => PrescriptionRepositoryImpl(
      context.read<IsarService>(),
      context.read<PrescriptionLocalRepository>(),
      context.read<CustomerLocalRepository>(),
      context.read<DoctorLocalRepository>(),
    ),
  ),

  Provider<CustomerRepository>(
    create: (context) => CustomerRepositoryImpl(
      isarService: context.read<IsarService>(),
      localRepository: context.read<CustomerLocalRepository>(),
      activityRepository: context.read<ActivityLocalRepository>(),
    ),
  ),

  Provider<FrameRepository>(
    create: (context) => FrameRepositoryImpl(
      context.read<IsarService>(),
      context.read<FrameLocalRepository>(),
    ),
  ),
  Provider<LensRepository>(
    create: (context) => LensRepositoryImpl(
      context.read<IsarService>(),
      context.read<LensLocalRepository>(),
    ),
  ),
  Provider<AccessoryRepository>(
    create: (context) => AccessoryRepositoryImpl(
      context.read<IsarService>(),
      context.read<AccessoryLocalRepository>(),
    ),
  ),
  Provider<IndexCounterRepository>(
    create: (context) =>
        IsarIndexCounterRepository(context.read<IsarService>()),
  ),
];

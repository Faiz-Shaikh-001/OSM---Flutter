import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/customer/data/customer_repository.dart';
import 'package:osm/features/dashboard/presentation/data/models/activity_repository.dart';
import 'package:osm/features/doctors/data/repositories/doctor_repository.dart';
import 'package:osm/features/inventory/data/repositories/frame_repository.dart';
import 'package:osm/features/inventory/data/repositories/lens_repository.dart';
import 'package:osm/features/inventory/data/repositories/store_location_repository.dart';
import 'package:osm/features/orders/data/repositories/payment_repository.dart';
import 'package:osm/features/prescription/data/repositories/prescription_repository.dart';
import 'package:provider/provider.dart';

final List<Provider> repositoryProviders = [
  Provider<ActivityRepository>(
    create: (context) => ActivityRepository(context.read<IsarService>()),
  ),
  Provider<CustomerRepository>(
    create: (context) => CustomerRepository(context.read<IsarService>(), context.read<ActivityRepository>()),
  ),
  Provider<DoctorRepository>(
    create: (context) => DoctorRepository(context.read<IsarService>()),
  ),
  Provider<PrescriptionRepository>(
    create: (context) => PrescriptionRepository(context.read<IsarService>()),
  ),
  Provider<PaymentRepository>(
    create: (context) => PaymentRepository(context.read<IsarService>()),
  ),
  Provider<StoreLocationRepository>(
    create: (context) => StoreLocationRepository(context.read<IsarService>()),
  ),
  Provider<FrameRepository>(
    create: (context) => FrameRepository(context.read<IsarService>()),
  ),
  Provider<LensRepository>(
    create: (context) => LensRepository(context.read<IsarService>()),
  ),
];

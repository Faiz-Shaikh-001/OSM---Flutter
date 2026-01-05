

import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/customer/data/repositories/customer_local_repository.dart';
import 'package:osm/features/dashboard/data/repositories/activity_local_repository.dart';
import 'package:osm/features/doctors/data/repositories/doctor_local_repository.dart';
import 'package:osm/features/inventory/data/repositories/accessory_local_repository.dart';
import 'package:osm/features/inventory/data/repositories/frame_local_repository.dart';
import 'package:osm/features/inventory/data/repositories/lens_local_repository.dart';
import 'package:osm/features/orders/data/repositories/order_local_repository.dart';
import 'package:osm/features/orders/data/repositories/payment_local_repository.dart';
import 'package:osm/features/prescription/data/repositories/prescription_local_repository.dart';
import 'package:osm/features/store/data/repositories/store_location_local_repository.dart';
import 'package:provider/provider.dart';

final List<Provider> localRepositoryProviders = [
  // Local Repositories
        Provider<CustomerLocalRepository>(
          create: (context) => CustomerLocalRepository(),
        ),

        Provider<ActivityLocalRepository>(
          create: (context) => ActivityLocalRepository(),
        ),

        Provider<OrderLocalRepository>(
          create: (context) =>
              OrderLocalRepository(context.read<IsarService>()),
        ),

        Provider<PaymentLocalRepository>(
          create: (context) =>
              PaymentLocalRepository(context.read<IsarService>()),
        ),

        Provider<PrescriptionLocalRepository>(
          create: (context) => PrescriptionLocalRepository(),
        ),

        Provider<DoctorLocalRepository>(
          create: (context) => DoctorLocalRepository(),
        ),

        Provider<StoreLocationLocalRepository>(
          create: (context) => StoreLocationLocalRepository(),
        ),

        Provider<AccessoryLocalRepository>(
          create: (context) => AccessoryLocalRepository(),
        ),

        Provider<FrameLocalRepository>(
          create: (context) => FrameLocalRepository(),
        ),

        Provider<LensLocalRepository>(
          create: (context) => LensLocalRepository(),
        ),

];

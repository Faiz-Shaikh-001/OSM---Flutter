import 'package:osm/features/customer/data/repositories/customer_local_repository.dart';
import 'package:osm/features/dashboard/data/repositories/activity_local_repository.dart';
import 'package:osm/features/doctors/data/repositories/doctor_local_repository.dart';
import 'package:osm/features/inventory/data/repositories/accessory_local_repository.dart';
import 'package:osm/features/inventory/data/repositories/frame_local_repository.dart';
import 'package:osm/features/inventory/data/repositories/lens_local_repository.dart';
import 'package:osm/features/orders/data/repositories/order_item_local_repository.dart';
import 'package:osm/features/orders/data/repositories/order_local_repository.dart';
import 'package:osm/features/orders/data/repositories/payment_local_repository.dart';
import 'package:osm/features/prescription/data/repositories/prescription_local_repository.dart';
import 'package:osm/features/store/data/repositories/store_location_local_repository.dart';
import 'package:provider/provider.dart';

final List<Provider> localRepositoryProviders = [
  // Local Repositories
  Provider<CustomerLocalRepository>(create: (_) => CustomerLocalRepository()),

  Provider<ActivityLocalRepository>(create: (_) => ActivityLocalRepository()),

  Provider<OrderItemLocalRepository>(create: (_) => OrderItemLocalRepository()),

  Provider<OrderLocalRepository>(create: (_) => OrderLocalRepository()),

  Provider<PaymentLocalRepository>(create: (_) => PaymentLocalRepository()),

  Provider<PrescriptionLocalRepository>(
    create: (_) => PrescriptionLocalRepository(),
  ),

  Provider<DoctorLocalRepository>(create: (_) => DoctorLocalRepository()),

  Provider<StoreLocationLocalRepository>(
    create: (_) => StoreLocationLocalRepository(),
  ),

  Provider<AccessoryLocalRepository>(create: (_) => AccessoryLocalRepository()),

  Provider<FrameLocalRepository>(create: (_) => FrameLocalRepository()),

  Provider<LensLocalRepository>(create: (context) => LensLocalRepository()),
];

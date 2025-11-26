import 'package:osm/features/customer/data/customer_repository.dart';
import 'package:osm/features/customer/viewmodel/customer_viewmodel.dart';
import 'package:osm/features/dashboard/presentation/data/models/activity_repository.dart';
import 'package:osm/features/dashboard/viewmodel/activity_view_model.dart';
import 'package:osm/features/inventory/data/repositories/frame_repository.dart';
import 'package:osm/features/inventory/data/repositories/lens_repository.dart';
import 'package:osm/features/inventory/data/repositories/store_location_repository.dart';
import 'package:osm/features/inventory/viewmodels/frame_viewmodel.dart';
import 'package:osm/features/inventory/viewmodels/lens_viewmodel.dart';
import 'package:osm/features/inventory/viewmodels/store_location_viewmodel.dart';
import 'package:osm/features/orders/data/repositories/order_repository.dart';
import 'package:osm/features/orders/viewmodel/order_viewmodel.dart';
import 'package:osm/features/prescription/data/repositories/prescription_repository.dart';
import 'package:osm/features/prescription/viewmodels/prescription_viewmodel.dart';
import 'package:provider/provider.dart';

final List<ChangeNotifierProvider> viewModelProviders = [
  ChangeNotifierProvider<CustomerViewModel>(
    create: (context) => CustomerViewModel(context.read<CustomerRepository>()),
  ),
  ChangeNotifierProvider<FrameViewmodel>(
    create: (context) => FrameViewmodel(context.read<FrameRepository>()),
  ),
  ChangeNotifierProvider<LensViewmodel>(
    create: (context) => LensViewmodel(context.read<LensRepository>()),
  ),
  ChangeNotifierProvider<OrderViewModel>(
    create: (context) => OrderViewModel(
      context.read<OrderRepository>(),
      context.read<CustomerViewModel>(),
    ),
  ),
  ChangeNotifierProvider<PrescriptionViewModel>(
    create: (context) =>
        PrescriptionViewModel(context.read<PrescriptionRepository>()),
  ),
  ChangeNotifierProvider<StoreLocationViewModel>(
    create: (context) =>
        StoreLocationViewModel(context.read<StoreLocationRepository>()),
  ),
  ChangeNotifierProvider<ActivityViewModel>(
    create: (context) => ActivityViewModel(context.read<ActivityRepository>()),
  ),
];

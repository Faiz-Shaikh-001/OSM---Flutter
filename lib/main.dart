import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/repositories/index_counter_repository.dart';
import 'package:osm/core/repositories/isar_index_counter_repository.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/theme_provider.dart';
import 'package:osm/features/customer/data/repositories/customer_local_repository.dart';
import 'package:osm/features/customer/data/repositories/customer_repository_impl.dart';
import 'package:osm/features/customer/domain/repositories/customer_repository.dart';
import 'package:osm/features/customer/domain/usecases/add_customer.dart';
import 'package:osm/features/customer/domain/usecases/delete_customer.dart';
import 'package:osm/features/customer/domain/usecases/get_customers.dart';
import 'package:osm/features/customer/domain/usecases/search_customers.dart';
import 'package:osm/features/customer/domain/usecases/update_customer.dart';
import 'package:osm/features/customer/domain/usecases/watch_customers_stream.dart';
import 'package:osm/features/customer/presentation/bloc/customer/customer_bloc.dart';
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
import 'package:osm/features/inventory/domain/usecases/accessory/create_accessory.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/delete_accessory.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/get_accessories_by_brand.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/get_accessories_by_name.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/get_accessory_by_id.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/get_all_accessories.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/update_accessory.dart';
import 'package:osm/features/inventory/domain/usecases/frames/create_frame.dart';
import 'package:osm/features/inventory/domain/usecases/frames/delete_frame.dart';
import 'package:osm/features/inventory/domain/usecases/frames/get_all_frames.dart';
import 'package:osm/features/inventory/domain/usecases/frames/get_by_type.dart';
import 'package:osm/features/inventory/domain/usecases/frames/get_frame_by_id.dart';
import 'package:osm/features/inventory/domain/usecases/frames/get_frames_by_company.dart';
import 'package:osm/features/inventory/domain/usecases/frames/get_frames_by_name.dart';
import 'package:osm/core/usecases/resolve_qr_scan.dart';
import 'package:osm/features/inventory/domain/usecases/frames/update_frame.dart';
import 'package:osm/features/inventory/domain/usecases/lens/create_lens.dart';
import 'package:osm/features/inventory/domain/usecases/lens/delete_lens.dart';
import 'package:osm/features/inventory/domain/usecases/lens/get_all_lenses.dart';
import 'package:osm/features/inventory/domain/usecases/lens/get_lens_by_id.dart';
import 'package:osm/features/inventory/domain/usecases/lens/get_lenses_by_company.dart';
import 'package:osm/features/inventory/domain/usecases/lens/get_lenses_by_product_name.dart';
import 'package:osm/features/inventory/domain/usecases/lens/get_lenses_by_type.dart';
import 'package:osm/features/inventory/domain/usecases/lens/update_lens.dart';
import 'package:osm/features/inventory/presentation/blocs/accessory/accessory_detail/accessory_detail_bloc.dart';
import 'package:osm/features/inventory/presentation/blocs/accessory/accessory_list/accessory_list_bloc.dart';
import 'package:osm/features/inventory/presentation/blocs/frames/frame_detail/frame_detail_bloc.dart';
import 'package:osm/features/inventory/presentation/blocs/frames/frame_list/frame_list_bloc.dart';
import 'package:osm/features/inventory/presentation/blocs/lens/lens_detail/lens_detail_bloc.dart';
import 'package:osm/features/inventory/presentation/blocs/lens/lens_list/lens_list_bloc.dart';
import 'package:osm/features/inventory/presentation/blocs/qr_scan/qr_scan_bloc.dart';
import 'package:osm/features/inventory/presentation/screens/inventory_screen.dart';
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
import 'package:osm/features/store/domain/usecases/ensure_active_store_location.dart';
import 'package:osm/features/store/domain/usecases/get_all_store_location.dart';
import 'package:osm/features/store/domain/usecases/get_store_locations.dart';
import 'package:osm/features/store/domain/usecases/set_active_store_location.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isarService = IsarService();
  await isarService.db;

  final storeLocalRepo = StoreLocationLocalRepository();
  final storeRepo = StoreLocationRepositoryImpl(isarService, storeLocalRepo);

  await storeRepo.seedStoreIfNeeded();
  final ensureActiveStore = EnsureActiveStoreLocation(storeRepo);
  await ensureActiveStore();

  runApp(
    MultiProvider(
      providers: [
        // Isar Service
        Provider<IsarService>.value(value: isarService),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

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
            orderLocal: context.read<OrderLocalRepository>(),
            paymentLocal: context.read<PaymentLocalRepository>(),
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

        // BlocProviders
        BlocProvider(
          create: (context) {
            final repo = context.read<StoreLocationRepository>();

            return StoreLocationBloc(
              getStoreLocations: GetStoreLocations(repo),
              getAllStoreLocation: GetAllStoreLocation(repo),
              setActiveStoreLocation: SetActiveStoreLocation(repo),
            )..add(LoadStoreLocations());
          },
        ),

        BlocProvider(
          create: (context) {
            final repo = context.read<CustomerRepository>();

            return CustomerBloc(
              addCustomer: AddCustomer(repo),
              updateCustomer: UpdateCustomer(repo),
              deleteCustomer: DeleteCustomer(repo),
              getCustomers: GetCustomers(repo),
              searchCustomers: SearchCustomers(repo),
              watchCustomersStream: WatchCustomersStream(repo),
            )..add(const LoadCustomers());
          },
        ),

        BlocProvider(
          create: (context) {
            final repo = context.read<FrameRepository>();

            return FrameListBloc(
              getAllFrames: GetAllFrames(repo),
              getFramesByCompany: GetFramesByCompany(repo),
              getFramesByName: GetFramesByName(repo),
              getFramesByType: GetFramesByType(repo),
              createFrame: CreateFrame(
                repo,
                context.read<IndexCounterRepository>(),
              ),
              updateFrame: UpdateFrame(
                repo,
                context.read<IndexCounterRepository>(),
              ),
              deleteFrame: DeleteFrame(repo),
            );
          },
        ),

        BlocProvider(
          create: (context) {
            final repo = context.read<FrameRepository>();

            return FrameDetailBloc(GetFrameById(repo));
          },
        ),

        BlocProvider(
          create: (context) {
            final repository = context.read<LensRepository>();

            return LensListBloc(
              getAllLenses: GetAllLenses(repository),
              getLensesByCompany: GetLensesByCompany(repository),
              getLensesByProductName: GetLensesByProductName(repository),
              getLensesByType: GetLensesByType(repository),
              createLens: CreateLens(
                repository,
                context.read<IndexCounterRepository>(),
              ),
              updateLens: UpdateLens(repository),
              deleteLens: DeleteLens(repository),
            );
          },
        ),

        BlocProvider(
          create: (context) {
            final repo = context.read<LensRepository>();
            return LensDetailBloc(GetLensById(repo));
          },
        ),

        BlocProvider(
          create: (context) {
            final repository = context.read<AccessoryRepository>();

            return AccessoryListBloc(
              getAllAccessories: GetAllAccessories(repository),
              getAccessoriesByBrand: GetAccessoriesByBrand(repository),
              getAccessoriesByName: GetAccessoriesByName(repository),
              createAccessory: CreateAccessory(repository, context.read<IndexCounterRepository>()),
              deleteAccessory: DeleteAccessory(repository),
              updateAccessory: UpdateAccessory(repository),
            );
          },
        ),

        BlocProvider(
          create: (context) {
            final repository = context.read<AccessoryRepository>();
            return AccessoryDetailBloc(
              getAccessoryById: GetAccessoryById(repository),
            );
          },
        ),

        BlocProvider(
          create: (context) {
            final frame = context.read<FrameRepository>();
            final lens = context.read<LensRepository>();
            final accessory = context.read<AccessoryRepository>();
            return QrScanBloc(
              resolveQrScan: ResolveQrScan(frame, lens, accessory),
            );
          },
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InventoryScreen(),
    );
  }
}

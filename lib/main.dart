import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/providers/bloc_providers.dart';
import 'package:osm/core/providers/local_repositories_providers.dart';
import 'package:osm/core/providers/repositories_impl_providers.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/theme_provider.dart';
// ignore: unused_import
import 'package:osm/features/inventory/presentation/screens/add_stock/screen/add_stock_screen.dart';
// ignore: unused_import
import 'package:osm/features/inventory/presentation/screens/inventory_screen.dart';
// import 'package:osm/features/customer/presentation/screens/customer_list_screen.dart';
// import 'package:osm/features/dashboard/presentation/screens/dashboard_screen.dart';
// import 'package:osm/features/inventory/presentation/screens/inventory_screen.dart';
// ignore: unused_import
import 'package:osm/features/orders/presentation/screens/add_order/create_order_flow_screen.dart';
import 'package:osm/features/orders/presentation/screens/order_list/order_list_screen.dart';
import 'package:osm/features/store/data/repositories/store_location_local_repository.dart';
import 'package:osm/features/store/data/repositories/store_location_repository_impl.dart';
import 'package:osm/features/store/domain/usecases/ensure_active_store_location.dart';
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
        ...localRepositoryProviders,
        ...repositoryImplProviders,
      ],

      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: buildBlocProviders(context),
            child: const MyApp(),
          );
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: CustomerListScreen(),
      // home: DashboardScreen(),
      // home: InventoryScreen(),
      // home: CreateOrderFlowScreen()
      home: OrderListScreen(),
    );
  }
}

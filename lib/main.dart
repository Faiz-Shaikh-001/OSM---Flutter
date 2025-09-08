import 'package:flutter/material.dart';
import 'package:osm/features/prescription/viewmodels/prescription_viewmodel.dart';
import 'package:osm/features/inventory/viewmodels/store_location_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import your IsarService
import 'package:osm/core/services/isar_service.dart';

// Import all your repository files
import 'package:osm/features/customer/data/customer_repository.dart';
import 'package:osm/features/doctors/data/repositories/doctor_repository.dart';
import 'package:osm/features/orders/data/repositories/order_repository.dart';
import 'package:osm/features/prescription/data/repositories/prescription_repository.dart';
import 'package:osm/features/orders/data/repositories/payment_repository.dart';
import 'package:osm/features/inventory/data/repositories/store_location_repository.dart';
import 'package:osm/features/inventory/data/repositories/inventory_repository.dart';
import 'package:osm/features/inventory/data/repositories/frame_repository.dart';
import 'package:osm/features/inventory/data/repositories/lens_repository.dart';

// Import your new ViewModel
import 'package:osm/features/customer/viewmodel/customer_viewmodel.dart'; // NEW IMPORT
import 'package:osm/features/inventory/viewmodels/frame_viewmodel.dart'; // NEW IMPORT
import 'package:osm/features/inventory/viewmodels/lens_viewmodel.dart'; // NEW IMPORT
import 'features/orders/viewmodel/order_viewmodel.dart';

// Import your initial screen
import 'features/dashboard/presentation/screens/dashboard_screen.dart';

// Import dummydatagenerator
import 'core/utils/dummy_data_generator.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isarService = IsarService();
  await isarService.db;
  sharedPreferences = await SharedPreferences.getInstance();

  // Dummy data population call
  await DummyDataGenerator.generate(isarService);

  runApp(
    MultiProvider(
      providers: [
        // Core Services/Repositories (Provider<T> for immutable instances)
        Provider<IsarService>(create: (_) => isarService),
        Provider<CustomerRepository>(
          create: (context) => CustomerRepository(context.read<IsarService>()),
        ),
        Provider<DoctorRepository>(
          create: (context) => DoctorRepository(context.read<IsarService>()),
        ),
        Provider<OrderRepository>(
          create: (context) => OrderRepository(context.read<IsarService>()),
        ),
        Provider<PrescriptionRepository>(
          create: (context) =>
              PrescriptionRepository(context.read<IsarService>()),
        ),
        Provider<PaymentRepository>(
          create: (context) => PaymentRepository(context.read<IsarService>()),
        ),
        Provider<StoreLocationRepository>(
          create: (context) =>
              StoreLocationRepository(context.read<IsarService>()),
        ),
        Provider<InventoryRepository>(
          create: (context) => InventoryRepository(context.read<IsarService>()),
        ),
        Provider<FrameRepository>(
          create: (context) => FrameRepository(context.read<IsarService>()),
        ),
        Provider<LensRepository>(
          create: (context) => LensRepository(context.read<IsarService>()),
        ),

        // ViewModels (ChangeNotifierProvider for mutable state)
        ChangeNotifierProvider<CustomerViewModel>(
          // NEW PROVIDER
          create: (context) =>
              CustomerViewModel(context.read<CustomerRepository>()),
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
        // Add other ViewModels here as you create them (e.g., DoctorViewModel)
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Optics Store Management',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DashboardScreen(),
    );
  }
}

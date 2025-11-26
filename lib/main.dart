import 'package:flutter/material.dart';
import 'package:osm/core/providers/repositories_providers.dart';
import 'package:osm/core/providers/services_providers.dart';
import 'package:osm/core/providers/viewmodel_providers.dart';
import 'package:osm/core/theme_provider.dart';
import 'package:osm/features/dashboard/presentation/data/models/activity_repository.dart';
import 'package:osm/features/dashboard/presentation/screens/dashboard_screen_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import your IsarService
import 'package:osm/core/services/isar_service.dart';

// Import all your repository files
import 'package:osm/features/orders/data/repositories/order_repository.dart';
import 'package:osm/features/inventory/data/repositories/inventory_repository.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isarService = IsarService();
  await isarService.db;
  sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ...servicesProvider,
        ...repositoryProviders,
        ChangeNotifierProvider<InventoryRepository>(
          create: (context) =>
              InventoryRepository(context.read<IsarService>())..init(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              OrderRepository(context.read<IsarService>(), context.read<ActivityRepository>())..init(),
        ),
        ...viewModelProviders,
        
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DashboardScreenTest(),
    );
  }
}

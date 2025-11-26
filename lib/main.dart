import 'package:flutter/material.dart';
import 'package:osm/core/providers/repositories_providers.dart';
import 'package:osm/core/providers/services_providers.dart';
import 'package:osm/core/providers/viewmodel_providers.dart';
import 'package:osm/core/theme_provider.dart';
import 'package:osm/features/dashboard/presentation/data/models/activity_repository.dart';
// --- FIX: Corrected import from _test.dart to the actual screen ---
import 'package:osm/features/dashboard/presentation/screens/dashboard_screen.dart';
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
        // Ensure InventoryRepository extends ChangeNotifier if using ChangeNotifierProvider
        ChangeNotifierProvider<InventoryRepository>(
          create: (context) =>
              InventoryRepository(context.read<IsarService>())..init(),
        ),
        // Ensure OrderRepository extends ChangeNotifier if using ChangeNotifierProvider
        ChangeNotifierProvider(
          create: (context) => OrderRepository(
            context.read<IsarService>(),
            context.read<ActivityRepository>(), // Ensure ActivityRepository is provided in repositoryProviders
          )..init(),
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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Optics Store Management',
          debugShowCheckedModeBanner: false,
          // --- THEME CONFIGURATION ---
          theme: ThemeData(
            useMaterial3: true, // Adapts colors for better contrast
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue, 
              brightness: Brightness.light
            ),
            scaffoldBackgroundColor: Colors.grey[50], // Matches your light UI background
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue, 
              brightness: Brightness.dark
            ),
            scaffoldBackgroundColor: const Color(0xFF121212), // Proper dark background
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          themeMode: themeProvider.themeMode, // Connects to the provider
          home: const DashboardScreen(),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/providers/bloc_providers.dart';
import 'package:osm/core/providers/local_repositories_providers.dart';
import 'package:osm/core/providers/repositories_impl_providers.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/theme_provider.dart';
import 'package:osm/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:osm/features/store/data/repositories/store_location_local_repository.dart';
import 'package:osm/features/store/data/repositories/store_location_repository_impl.dart';
import 'package:osm/features/store/domain/usecases/ensure_active_store_location.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Required for interacting with the Flutter engine before runApp() (e.g., Isar, Plugins)
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Local Database (Isar)
  final isarService = IsarService();
  await isarService.db;

  // Initialize Repositories
  final storeLocalRepo = StoreLocationLocalRepository();
  final storeRepo = StoreLocationRepositoryImpl(isarService, storeLocalRepo);

  // Data Pre-seeding and Business Logic checks before the UI launches
  await storeRepo.seedStoreIfNeeded();
  final ensureActiveStore = EnsureActiveStoreLocation(storeRepo);
  await ensureActiveStore();

  runApp(
    MultiProvider(
      providers: [
        // Make the Isar service available thoughout the app
        Provider<IsarService>.value(value: isarService),

        // Handle global app theme state
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        // Spread operators to inject local and implementation repositories
        ...localRepositoryProviders,
        ...repositoryImplProviders,
      ],

      child: Builder(
        builder: (context) {
          // Wrap the app in MultiBlocProvider to handle business logic states
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
    // Root Widget: Sets up the visual framework and initial route
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

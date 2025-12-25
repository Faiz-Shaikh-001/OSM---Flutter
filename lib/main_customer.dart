import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/theme_provider.dart';
import 'package:osm/features/customer/data/repositories/customer_local_repository.dart';
import 'package:osm/features/customer/data/repositories/customer_repository_impl.dart';
import 'package:osm/features/customer/domain/usecases/add_customer.dart';
import 'package:osm/features/customer/domain/usecases/delete_customer.dart';
import 'package:osm/features/customer/domain/usecases/get_customers.dart';
import 'package:osm/features/customer/domain/usecases/search_customers.dart';
import 'package:osm/features/customer/domain/usecases/update_customer.dart';
import 'package:osm/features/customer/domain/usecases/watch_customers_stream.dart';
import 'package:osm/features/customer/presentation/bloc/customer/customer_bloc.dart';
import 'package:osm/features/customer/presentation/screens/customer_list_screen.dart';
import 'package:osm/features/dashboard/data/repositories/activity_local_repository.dart';
import 'package:osm/features/dashboard/data/repositories/activity_repository_impl.dart';
import 'package:osm/features/doctors/data/repositories/doctor_repository.dart';
import 'package:osm/features/orders/data/repositories/order_local_repository.dart';
import 'package:osm/features/orders/data/repositories/order_repository_impl.dart';
import 'package:osm/features/orders/data/repositories/payment_local_repository.dart';
import 'package:osm/features/prescription/data/repositories/prescription_local_repository.dart';
import 'package:osm/features/prescription/data/repositories/prescription_repository_impl.dart';
import 'package:osm/features/prescription/domain/usecases/add_prescription.dart';
import 'package:osm/features/prescription/domain/usecases/get_prescription_history.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isarService = IsarService();
  await isarService.db;

  runApp(
    MultiProvider(
      providers: [
        // Isar Service
        Provider<IsarService>.value(value: isarService),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        // Local Repositories
        Provider(
          create: (context) =>
              CustomerLocalRepository(context.read<IsarService>()),
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

        // RepositoryImpl
        Provider(
          create: (context) => ActivityRepositoryImpl(
            context.read<IsarService>(),
            context.read<ActivityLocalRepository>(),
          ),
        ),

        Provider<OrderRepositoryImpl>(
          create: (context) => OrderRepositoryImpl(
            orderLocal: context.read<OrderLocalRepository>(),
            paymentLocal: context.read<PaymentLocalRepository>(),
          ),
        ),

        Provider<DoctorRepositoryImpl>(
          create: (context) =>
              DoctorRepositoryImpl(context.read<IsarService>()),
        ),

        Provider<PrescriptionRepositoryImpl>(
          create: (context) => PrescriptionRepositoryImpl(
            context.read<IsarService>(),
            context.read<PrescriptionLocalRepository>(),
            context.read<CustomerLocalRepository>(),
            context.read<DoctorRepositoryImpl>(),
          ),
        ),

        Provider<GetPrescriptionHistory>(
          create: (context) => GetPrescriptionHistory(
            context.read<PrescriptionRepositoryImpl>(),
          ),
        ),

        Provider<AddPrescription>(
          create: (context) => AddPrescription(
            context.read<PrescriptionRepositoryImpl>(),
          ),
        ),

        Provider(
          create: (context) => CustomerRepositoryImpl(
            isarService: context.read<IsarService>(),
            localRepository: context.read<CustomerLocalRepository>(),
            activityRepository: context.read<ActivityLocalRepository>(),
          ),
        ),

        BlocProvider(
          create: (context) {
            final repo = context.read<CustomerRepositoryImpl>();

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
      home: CustomerListScreen(),
    );
  }
}

// import 'package:osm/core/services/isar_service.dart';
// import 'package:osm/features/doctors/data/repositories/doctor_repository.dart';
// import 'package:osm/features/inventory/data/repositories/frame_repository.dart';
// import 'package:osm/features/inventory/data/repositories/lens_repository.dart';
// import 'package:osm/features/inventory/data/repositories/store_location_repository.dart';
// import 'package:osm/features/orders/data/repositories/payment_local_repository.dart';
// import 'package:osm/features/prescription/data/repositories/prescription_repository.dart';
// import 'package:provider/provider.dart';

// final List<Provider> repositoryProviders = [
//   Provider<DoctorRepository>(
//     create: (context) => DoctorRepository(context.read<IsarService>()),
//   ),
//   Provider<PrescriptionRepository>(
//     create: (context) => PrescriptionRepository(context.read<IsarService>()),
//   ),

//   Provider<StoreLocationRepository>(
//     create: (context) => StoreLocationRepository(context.read<IsarService>()),
//   ),
//   Provider<FrameRepository>(
//     create: (context) => FrameRepository(context.read<IsarService>()),
//   ),
//   Provider<LensRepository>(
//     create: (context) => LensRepository(context.read<IsarService>()),
//   ),
// ];

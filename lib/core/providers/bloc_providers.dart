import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/repositories/index_counter_repository.dart';
import 'package:osm/core/usecases/resolve_qr_scan.dart';
import 'package:osm/features/customer/domain/repositories/customer_repository.dart';
import 'package:osm/features/customer/domain/usecases/add_customer.dart';
import 'package:osm/features/customer/domain/usecases/delete_customer.dart';
import 'package:osm/features/customer/domain/usecases/get_customers.dart';
import 'package:osm/features/customer/domain/usecases/search_customers.dart';
import 'package:osm/features/customer/domain/usecases/update_customer.dart';
import 'package:osm/features/customer/domain/usecases/watch_customers_stream.dart';
import 'package:osm/features/customer/presentation/bloc/customer/customer_bloc.dart';
import 'package:osm/features/dashboard/domain/repositories/activity_repository.dart';
import 'package:osm/features/dashboard/domain/usecases/save_activity.dart';
import 'package:osm/features/dashboard/domain/usecases/watch_recent_activities.dart';
import 'package:osm/features/dashboard/presentation/blocs/activity/activity_bloc.dart';
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
import 'package:osm/features/prescription/domain/repositories/prescription_repository.dart';
import 'package:osm/features/prescription/domain/usecases/add_prescription.dart';
import 'package:osm/features/prescription/domain/usecases/get_prescription_history.dart';
import 'package:osm/features/prescription/presentation/bloc/add_prescription/add_prescription_bloc.dart';
import 'package:osm/features/prescription/presentation/bloc/prescription_timeline/prescription_timeline_bloc.dart';
import 'package:osm/features/store/domain/repositories/store_location_repository.dart';
import 'package:osm/features/store/domain/usecases/get_all_store_location.dart';
import 'package:osm/features/store/domain/usecases/get_store_locations.dart';
import 'package:osm/features/store/domain/usecases/set_active_store_location.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';

List<BlocProvider> buildBlocProviders(BuildContext context) {
  final storeLocationRepository = context.read<StoreLocationRepository>();
  final customerRepository = context.read<CustomerRepository>();
  final frameRepository = context.read<FrameRepository>();
  final counterRepository = context.read<IndexCounterRepository>();
  final lensRepository = context.read<LensRepository>();
  final accessoryRepository = context.read<AccessoryRepository>();
  final prescriptionRepository = context.read<PrescriptionRepository>();
  final activityReposistory = context.read<ActivityRepository>();

  return [
    // BlocProviders
    BlocProvider<ActivityBloc>(
      create: (_) => ActivityBloc(
        saveActivity: SaveActivity(activityReposistory),
        watchRecentActivities: WatchRecentActivities(activityReposistory),
      ),
    ),

    BlocProvider<StoreLocationBloc>(
      create: (_) => StoreLocationBloc(
        getStoreLocations: GetStoreLocations(storeLocationRepository),
        getAllStoreLocation: GetAllStoreLocation(storeLocationRepository),
        setActiveStoreLocation: SetActiveStoreLocation(storeLocationRepository),
      )..add(LoadStoreLocations()),
    ),

    BlocProvider<CustomerBloc>(
      create: (_) => CustomerBloc(
        addCustomer: AddCustomer(customerRepository),
        updateCustomer: UpdateCustomer(customerRepository),
        deleteCustomer: DeleteCustomer(customerRepository),
        getCustomers: GetCustomers(customerRepository),
        searchCustomers: SearchCustomers(customerRepository),
        watchCustomersStream: WatchCustomersStream(customerRepository),
      )..add(const LoadCustomers()),
    ),

    BlocProvider<FrameListBloc>(
      create: (_) => FrameListBloc(
        getAllFrames: GetAllFrames(frameRepository),
        getFramesByCompany: GetFramesByCompany(frameRepository),
        getFramesByName: GetFramesByName(frameRepository),
        getFramesByType: GetFramesByType(frameRepository),
        createFrame: CreateFrame(frameRepository, counterRepository),
        updateFrame: UpdateFrame(frameRepository, counterRepository),
        deleteFrame: DeleteFrame(frameRepository),
      ),
    ),

    BlocProvider<FrameDetailBloc>(
      create: (_) => FrameDetailBloc(GetFrameById(frameRepository)),
    ),

    BlocProvider<LensListBloc>(
      create: (_) => LensListBloc(
        getAllLenses: GetAllLenses(lensRepository),
        getLensesByCompany: GetLensesByCompany(lensRepository),
        getLensesByProductName: GetLensesByProductName(lensRepository),
        getLensesByType: GetLensesByType(lensRepository),
        createLens: CreateLens(lensRepository, counterRepository),
        updateLens: UpdateLens(lensRepository),
        deleteLens: DeleteLens(lensRepository),
      ),
    ),

    BlocProvider<LensDetailBloc>(
      create: (_) => LensDetailBloc(GetLensById(lensRepository)),
    ),

    BlocProvider<AccessoryListBloc>(
      create: (_) => AccessoryListBloc(
        getAllAccessories: GetAllAccessories(accessoryRepository),
        getAccessoriesByBrand: GetAccessoriesByBrand(accessoryRepository),
        getAccessoriesByName: GetAccessoriesByName(accessoryRepository),
        createAccessory: CreateAccessory(
          accessoryRepository,
          counterRepository,
        ),
        deleteAccessory: DeleteAccessory(accessoryRepository),
        updateAccessory: UpdateAccessory(accessoryRepository),
      ),
    ),

    BlocProvider<AccessoryDetailBloc>(
      create: (_) => AccessoryDetailBloc(
        getAccessoryById: GetAccessoryById(accessoryRepository),
      ),
    ),

    BlocProvider<QrScanBloc>(
      create: (_) => QrScanBloc(
        resolveQrScan: ResolveQrScan(
          frameRepository,
          lensRepository,
          accessoryRepository,
        ),
      ),
    ),

    BlocProvider<PrescriptionTimelineBloc>(
      create: (_) => PrescriptionTimelineBloc(
        getPrescriptionHistory: GetPrescriptionHistory(prescriptionRepository),
      ),
    ),

    BlocProvider<AddPrescriptionBloc>(
      create: (_) => AddPrescriptionBloc(
        addPrescription: AddPrescription(prescriptionRepository),
      ),
    ),
  ];
}

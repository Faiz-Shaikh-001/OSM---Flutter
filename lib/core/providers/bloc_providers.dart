import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Core & Utilities
import 'package:osm/core/repositories/index_counter_repository.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/usecases/resolve_qr_scan.dart';
import 'package:osm/core/value_objects/id.dart';

// Customer Feature
import 'package:osm/features/customer/data/repositories/customer_local_repository.dart';
import 'package:osm/features/customer/domain/repositories/customer_repository.dart';
import 'package:osm/features/customer/domain/usecases/add_customer.dart';
import 'package:osm/features/customer/domain/usecases/delete_customer.dart';
import 'package:osm/features/customer/domain/usecases/get_customer_details.dart';
import 'package:osm/features/customer/domain/usecases/get_customers.dart';
import 'package:osm/features/customer/domain/usecases/search_customers.dart';
import 'package:osm/features/customer/domain/usecases/update_customer.dart';
import 'package:osm/features/customer/domain/usecases/watch_customers_stream.dart';
import 'package:osm/features/customer/presentation/bloc/customer/customer_bloc.dart';
import 'package:osm/features/customer/presentation/bloc/customer_details/customer_details_bloc.dart';

// Dashboard & Search
import 'package:osm/features/dashboard/application/search/search_everything.dart';
import 'package:osm/features/dashboard/data/sources_impl/accessory_search_source_impl.dart';
import 'package:osm/features/dashboard/data/sources_impl/customer_search_source_impl.dart';
import 'package:osm/features/dashboard/data/sources_impl/doctor_search_source_impl.dart';
import 'package:osm/features/dashboard/data/sources_impl/frame_search_source_impl.dart';
import 'package:osm/features/dashboard/data/sources_impl/lens_search_source_impl.dart';
import 'package:osm/features/dashboard/data/sources_impl/order_search_source_impl.dart';
import 'package:osm/features/dashboard/domain/repositories/activity_repository.dart';
import 'package:osm/features/dashboard/domain/usecases/save_activity.dart';
import 'package:osm/features/dashboard/domain/usecases/watch_recent_activities.dart';
import 'package:osm/features/dashboard/presentation/blocs/activity/activity_bloc.dart';
import 'package:osm/features/dashboard/presentation/blocs/dashboard/dashboard_bloc.dart';
import 'package:osm/features/dashboard/presentation/blocs/global_search/global_search_bloc.dart';

// Doctors
import 'package:osm/features/doctors/domain/repositories/doctor_repository.dart';
import 'package:osm/features/doctors/data/repositories/doctor_local_repository.dart';

// Inventory
import 'package:osm/features/inventory/data/repositories/accessory_local_repository.dart';
import 'package:osm/features/inventory/data/repositories/frame_local_repository.dart';
import 'package:osm/features/inventory/data/repositories/lens_local_repository.dart';
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

// Orders
import 'package:osm/features/orders/data/repositories/order_local_repository.dart';
import 'package:osm/features/orders/domain/repositories/order_repository.dart';
import 'package:osm/features/orders/domain/usecases/add_payment.dart';
import 'package:osm/features/orders/domain/usecases/create_order_from_draft.dart';
import 'package:osm/features/orders/domain/usecases/get_orders.dart';
import 'package:osm/features/orders/domain/usecases/watch_active_order_count.dart';
import 'package:osm/features/orders/domain/usecases/watch_pending_payments.dart';
import 'package:osm/features/orders/domain/usecases/watch_todays_sale.dart';
import 'package:osm/features/orders/presentation/blocs/order_submission/order_submission_bloc.dart';

// Prescription
import 'package:osm/features/prescription/domain/repositories/prescription_repository.dart';
import 'package:osm/features/prescription/domain/usecases/add_prescription.dart';
import 'package:osm/features/prescription/domain/usecases/get_prescription_history.dart';
import 'package:osm/features/prescription/presentation/bloc/add_prescription/add_prescription_bloc.dart';
import 'package:osm/features/prescription/presentation/bloc/prescription_timeline/prescription_timeline_bloc.dart';

// Store & Staff
import 'package:osm/features/store/domain/repositories/store_location_repository.dart';
import 'package:osm/features/store/domain/usecases/get_all_store_location.dart';
import 'package:osm/features/store/domain/usecases/get_store_locations.dart';
import 'package:osm/features/store/domain/usecases/set_active_store_location.dart';
import 'package:osm/features/store/domain/usecases/add_store_location.dart';
import 'package:osm/features/store/domain/usecases/update_store_location.dart';
import 'package:osm/features/store/domain/usecases/delete_store_location.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';
import 'package:osm/features/staff/data/repositories/staff_repository_impl.dart';
import 'package:osm/features/staff/domain/usecases/add_staff.dart';
import 'package:osm/features/staff/domain/usecases/get_staff.dart';
import 'package:osm/features/staff/domain/usecases/update_staff.dart';
import 'package:osm/features/staff/domain/usecases/delete_staff.dart';
import 'package:osm/features/staff/presentation/bloc/staff_bloc.dart';
import 'package:osm/features/staff/presentation/bloc/staff_event.dart';

// Settings
import 'package:osm/features/settings/settings_di.dart';

List<BlocProvider> buildBlocProviders(BuildContext context) {
  // Repository extraction from Context
  final storeLocationRepository = context.read<StoreLocationRepository>();
  final customerRepository = context.read<CustomerRepository>();
  final frameRepository = context.read<FrameRepository>();
  final counterRepository = context.read<IndexCounterRepository>();
  final lensRepository = context.read<LensRepository>();
  final accessoryRepository = context.read<AccessoryRepository>();
  final prescriptionRepository = context.read<PrescriptionRepository>();
  final activityReposistory = context.read<ActivityRepository>();
  final orderRepository = context.read<OrderRepository>();
  final doctorRepository = context.read<DoctorRepository>();
  final isarService = context.read<IsarService>();
  // Manual Repo initialization for Staff
  final staffRepository = StaffRepositoryImpl(isarService);

  return [
    // Activity Bloc
    BlocProvider<ActivityBloc>(
      create: (_) => ActivityBloc(
        saveActivity: SaveActivity(activityReposistory),
        watchRecentActivities: WatchRecentActivities(activityReposistory),
      ),
    ),

    // Unified Global Search Bloc (SourceImpl Pattern)
    BlocProvider<GlobalSearchBloc>(
      create: (_) => GlobalSearchBloc(
        searchEverything: SearchEverything(
          orderSearch: OrderSearchSourceImpl(isarService, OrderLocalRepository()),
          customerSearch: CustomerSearchSourceImpl(isarService, CustomerLocalRepository()),
          frameSearch: FrameSearchSourceImpl(isarService, FrameLocalRepository()),
          lensSearch: LensSearchSourceImpl(isarService, LensLocalRepository()),
          accessorySearch: AccessorySearchSourceImpl(isarService, AccessoryLocalRepository()),
          doctorSearch: DoctorSearchSourceImpl(isarService, DoctorLocalRepository()),
        ),
      ),
    ),

    // Dashboard Bloc with full stats
    BlocProvider<DashboardBloc>(
      create: (_) => DashboardBloc(
        getOrders: GetOrders(orderRepository),
        getAllFrames: GetAllFrames(frameRepository),
        getAllAccessories: GetAllAccessories(accessoryRepository),
        watchRecentActivities: WatchRecentActivities(activityReposistory),
        watchActiveOrderCount: WatchActiveOrderCount(orderRepository),
        watchPendingPayments: WatchPendingPayments(orderRepository),
        watchTodaysSale: WatchTodaysSale(orderRepository),
      ),
    ),

    // Store Location Bloc (Full CRUD)
    BlocProvider<StoreLocationBloc>(
      create: (_) => StoreLocationBloc(
        getStoreLocations: GetStoreLocations(storeLocationRepository),
        getAllStoreLocation: GetAllStoreLocation(storeLocationRepository),
        setActiveStoreLocation: SetActiveStoreLocation(storeLocationRepository),
        addStoreLocation: AddStoreLocation(storeLocationRepository),
        updateStoreLocation: UpdateStoreLocation(storeLocationRepository),
        deleteStoreLocation: DeleteStoreLocation(storeLocationRepository),
      )..add(LoadStoreLocations()),
    ),

    // Customer Blocs
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

    BlocProvider<CustomerDetailsBloc>(
      create: (_) => CustomerDetailsBloc(
        getCustomerDetails: GetCustomerDetails(
          customerRepository,
          orderRepository,
          prescriptionRepository,
        ),
        deleteCustomer: DeleteCustomer(customerRepository),
      ),
    ),

    // Inventory Blocs: Frames
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

    // Inventory Blocs: Lens
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

    // Inventory Blocs: Accessory
    BlocProvider<AccessoryListBloc>(
      create: (_) => AccessoryListBloc(
        getAllAccessories: GetAllAccessories(accessoryRepository),
        getAccessoriesByBrand: GetAccessoriesByBrand(accessoryRepository),
        getAccessoriesByName: GetAccessoriesByName(accessoryRepository),
        createAccessory: CreateAccessory(accessoryRepository, counterRepository),
        deleteAccessory: DeleteAccessory(accessoryRepository),
        updateAccessory: UpdateAccessory(accessoryRepository),
      ),
    ),

    BlocProvider<AccessoryDetailBloc>(
      create: (_) => AccessoryDetailBloc(
        getAccessoryById: GetAccessoryById(accessoryRepository),
      ),
    ),

    // Utilities & QR
    BlocProvider<QrScanBloc>(
      create: (_) => QrScanBloc(
        resolveQrScan: ResolveQrScan(
          frameRepository,
          lensRepository,
          accessoryRepository,
        ),
      ),
    ),

    // Prescription Blocs
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

    // Order Submission Bloc
    BlocProvider<OrderSubmissionBloc>(
      create: (_) => OrderSubmissionBloc(
        createOrderFromDraft: CreateOrderFromDraft(orderRepository),
        addPayment: AddPayment(orderRepository),
      ),
    ),

    // Staff Bloc (Store Specific)
    BlocProvider<StaffBloc>(
      create: (_) => StaffBloc(
        getStaff: GetStaff(staffRepository),
        addStaff: AddStaff(staffRepository),
        updateStaff: UpdateStaff(staffRepository),
        deleteStaff: DeleteStaff(staffRepository),
      )..add(LoadStaff(storeId: const StoreLocationId('1'))),
    ),

    // Settings spread operator
    ...settingsBlocProviders(),
  ];
}
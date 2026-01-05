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
import 'package:osm/features/store/domain/repositories/store_location_repository.dart';
import 'package:osm/features/store/domain/usecases/get_all_store_location.dart';
import 'package:osm/features/store/domain/usecases/get_store_locations.dart';
import 'package:osm/features/store/domain/usecases/set_active_store_location.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';

final List<BlocProvider> blocProviders = [
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
        createFrame: CreateFrame(repo, context.read<IndexCounterRepository>()),
        updateFrame: UpdateFrame(repo, context.read<IndexCounterRepository>()),
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
        createAccessory: CreateAccessory(
          repository,
          context.read<IndexCounterRepository>(),
        ),
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
      return QrScanBloc(resolveQrScan: ResolveQrScan(frame, lens, accessory));
    },
  ),
];

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osm/core/either.dart';
import 'package:osm/features/customer/domain/entities/customer.dart';
import 'package:osm/features/customer/domain/failures/customer_failure.dart';
import 'package:osm/features/customer/domain/usecases/get_customers.dart';
import 'package:osm/features/dashboard/presentation/models/search_results_ui_model.dart';
import 'package:osm/features/doctors/domain/entities/doctor.dart';
import 'package:osm/features/doctors/domain/failures/doctor_failure.dart';
import 'package:osm/features/doctors/domain/usecases/get_all_doctors.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/failures/accessory/accessory_failure.dart';
import 'package:osm/features/inventory/domain/failures/frames/frame_failure.dart';
import 'package:osm/features/inventory/domain/failures/lens/lens_failure.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/get_all_accessories.dart';
import 'package:osm/features/inventory/domain/usecases/frames/get_all_frames.dart';
import 'package:osm/features/inventory/domain/usecases/lens/get_all_lenses.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:osm/features/orders/domain/failures/order_failure.dart';
import 'package:osm/features/orders/domain/usecases/get_orders.dart';

part 'global_search_event.dart';
part 'global_search_state.dart';

class GlobalSearchBloc extends Bloc<GlobalSearchEvent, GlobalSearchState> {
  final GetOrders _getOrders;
  final GetAllFrames _getAllFrames;
  final GetAllAccessories _getAllAccessories;
  final GetCustomers _getAllCustomers;
  final GetAllDoctors _getAllDoctors;
  final GetAllLenses _getAllLenses;

  List<SearchResultUiModel> _searchDatabase = [];

  GlobalSearchBloc({
    required GetOrders getOrders,
    required GetAllFrames getAllFrames,
    required GetAllAccessories getAllAccessories,
    required GetCustomers getAllCustomers,
    required GetAllDoctors getAllDoctors,
    required GetAllLenses getAllLenses,
  }) : _getOrders = getOrders,
       _getAllFrames = getAllFrames,
       _getAllAccessories = getAllAccessories,
       _getAllCustomers = getAllCustomers,
       _getAllDoctors = getAllDoctors,
       _getAllLenses = getAllLenses,
       super(GlobalSearchInitial()) {
    on<LoadSearchData>(_onLoadData);
    on<QueryChanged>(_onQueryChanged);
  }

  Future<void> _onLoadData(
    LoadSearchData event,
    Emitter<GlobalSearchState> emit,
  ) async {
    emit(GlobalSearchLoading());
    try {
      final results = await Future.wait([
        _getOrders(),
        _getAllFrames(),
        _getAllAccessories(),
        _getAllLenses(),
        _getAllCustomers(),
        _getAllDoctors(),
      ]);

      final List<SearchResultUiModel> allItems = [];

      final orders = results[0] as Either<OrderFailure, List<Order>>;
      final frames = results[1] as Either<FrameFailure, List<Frame>>;
      final lenses = results[2] as Either<LensFailure, List<Lens>>;
      final accessories =
          results[3] as Either<AccessoryFailure, List<Accessory>>;
      final customers = results[4] as Either<CustomerFailure, List<Customer>>;
      final doctors = results[5] as Either<DoctorFailure, List<Doctor>>;

      orders.fold(
        (_) => null,
        (list) => allItems.addAll(
          list.map(
            (o) => SearchResultUiModel(
              title: "Order #${o.id}",
              subtitle: "Customer: ${o.customerId}",
              type: SearchResultType.order,
              icon: Icons.receipt_long,
              payload: o,
            ),
          ),
        ),
      );

      frames.fold((_) => null, (frames) {
        for (var frame in frames) {
          allItems.add(
            SearchResultUiModel(
              title: frame.name,
              subtitle: "${frame.companyName} - ${frame.type.name}",
              type: SearchResultType.frame,
              icon: CupertinoIcons.eyeglasses,
              payload: frame,
            ),
          );

          for (var variant in frame.variants) {
            allItems.add(
              SearchResultUiModel(
                title: "${frame.name} (${variant.colorName})",
                subtitle: "SKU: ${variant.sku} | Size: ${variant.size}",
                type: SearchResultType.frame,
                icon: Icons.inventory_2_outlined,
                payload: frame,
              ),
            );
          }
        }
      });

      lenses.fold(
        (_) => null,
        (list) => allItems.addAll(
          list.map(
            (l) => SearchResultUiModel(
              title: l.companyName,
              subtitle: l.productName,
              type: SearchResultType.lens,
              icon: Icons.lens,
              payload: l,
            ),
          ),
        ),
      );

      accessories.fold(
        (_) => null,
        (list) => allItems.addAll(
          list.map(
            (a) => SearchResultUiModel(
              title: a.brand,
              subtitle: a.name,
              type: SearchResultType.accessory,
              icon: Icons.luggage,
              payload: a,
            ),
          ),
        ),
      );

      customers.fold(
        (_) => null,
        (list) => allItems.addAll(
          list.map(
            (c) => SearchResultUiModel(
              title: c.fullName,
              subtitle: "Phone: ${c.primaryPhoneNumber}",
              type: SearchResultType.customer,
              icon: Icons.person,
              payload: c,
            ),
          ),
        ),
      );

      doctors.fold(
        (_) => null,
        (list) => allItems.addAll(
          list.map(
            (d) => SearchResultUiModel(
              title: "Dr. ${d.name}",
              subtitle: d.designation,
              type: SearchResultType.doctor,
              icon: Icons.medical_services,
              payload: d,
            ),
          ),
        ),
      );

      _searchDatabase = allItems;
      emit(GlobalSearchInitial());
    } catch (e) {
      emit(const GlobalSearchError('Failed to load search data'));
    }
  }

  void _onQueryChanged(QueryChanged event, Emitter<GlobalSearchState> emit) {
    if (event.query.isEmpty) {
      emit(GlobalSearchInitial());
      return;
    }

    final query = event.query.toLowerCase();
    final filtered = _searchDatabase.where((item) {
      return item.title.toLowerCase().contains(query) ||
          item.subtitle.toLowerCase().contains(query);
    }).toList();

    emit(filtered.isEmpty ? GlobalSearchEmpty() : GlobalSearchLoaded(filtered));
  }
}

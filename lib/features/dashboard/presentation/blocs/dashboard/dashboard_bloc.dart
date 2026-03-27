import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/dashboard/domain/entities/activity.dart';
import 'package:osm/features/dashboard/domain/usecases/watch_recent_activities.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/failures/accessory/accessory_failure.dart';
import 'package:osm/features/inventory/domain/failures/frames/frame_failure.dart';
import 'package:osm/features/inventory/domain/usecases/accessory/get_all_accessories.dart';
import 'package:osm/features/inventory/domain/usecases/frames/get_all_frames.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:osm/features/orders/domain/entities/order_enums.dart';
import 'package:osm/features/orders/domain/failures/order_failure.dart';
import 'package:osm/features/orders/domain/usecases/get_orders.dart';
import 'package:osm/features/orders/domain/usecases/watch_active_order_count.dart';
import 'package:osm/features/orders/domain/usecases/watch_pending_payments.dart';
import 'package:osm/features/orders/domain/usecases/watch_todays_sale.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetOrders _getOrders;
  final GetAllFrames _getAllFrames;
  final GetAllAccessories _getAllAccessories;
  final WatchRecentActivities _watchRecentActivities;
  final WatchActiveOrderCount _watchActiveOrderCount;
  final WatchPendingPayments _watchPendingPayments;
  final WatchTodaysSale _watchTodaysSale;

  StreamSubscription? _activitySubscription;
  StreamSubscription? _orderCountSubscription;
  StreamSubscription? _pendingPaymentSubscription;
  StreamSubscription? _todaysSaleSubscription;

  DashboardBloc({
    required GetOrders getOrders,
    required GetAllFrames getAllFrames,
    required GetAllAccessories getAllAccessories,
    required WatchRecentActivities watchRecentActivities,
    required WatchActiveOrderCount watchActiveOrderCount,
    required WatchPendingPayments watchPendingPayments,
    required WatchTodaysSale watchTodaysSale,
  }) : _getOrders = getOrders,
       _getAllFrames = getAllFrames,
       _getAllAccessories = getAllAccessories,
       _watchRecentActivities = watchRecentActivities,
       _watchActiveOrderCount = watchActiveOrderCount,
       _watchPendingPayments = watchPendingPayments,
       _watchTodaysSale = watchTodaysSale,
       super(const DashboardState()) {
    on<DashboardStarted>(_onDashboardStarted);
    on<DashboardRefreshRequested>(_onDashboardRefreshRequested);
    on<DashboardDataUpdated>(_onDashboardDataUpdated);
  }

  Future<void> _onDashboardStarted(
    DashboardStarted event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: DashboardStatus.loading));

    // Initial manual laod for static/inventory data
    await _loadDashboardSnapshot(emit);

    // Setup Activity Stream (Reactive)
    _activitySubscription?.cancel();
    _activitySubscription = _watchRecentActivities.call().listen(
      (activities) => add(DashboardDataUpdated(activities: activities)),
      onError: (error) {
        debugPrint(error);
      },
    );

    // Setup Order Count Stream (Reactive)
    _orderCountSubscription?.cancel();
    _orderCountSubscription = _watchActiveOrderCount.call().listen(
      (count) => add(DashboardDataUpdated(activeOrderCount: count)),
    );

    // Setup Pending Payment Stream (Reactive)
    _pendingPaymentSubscription?.cancel();
    _pendingPaymentSubscription = _watchPendingPayments.call().listen(
      (payment) => add(DashboardDataUpdated(pendingPayments: payment)),
    );

    // Setup Todays Sale Stream (Reactive)
    _todaysSaleSubscription?.cancel();
    _todaysSaleSubscription = _watchTodaysSale.call().listen(
      (sale) => add(DashboardDataUpdated(todaysSale: sale)),
    );
  }

  Future<void> _onDashboardRefreshRequested(
    DashboardRefreshRequested event,
    Emitter<DashboardState> emit,
  ) async {
    await _loadDashboardSnapshot(emit);
  }

  void _onDashboardDataUpdated(
    DashboardDataUpdated event,
    Emitter<DashboardState> emit,
  ) {
    emit(
      state.copyWith(
        recentActivities: event.activities,
        activeOrderCount: event.activeOrderCount ?? state.activeOrderCount,
        pendingPayments: event.pendingPayments ?? state.pendingPayments,
        dailySales: event.todaysSale ?? state.dailySales,
      ),
    );
  }

  Future<void> _loadDashboardSnapshot(Emitter<DashboardState> emit) async {
    final results = await Future.wait([
      _getOrders.call(),
      _getAllFrames.call(),
      _getAllAccessories.call(),
    ]);

    final ordersResult = results[0] as Either<OrderFailure, List<Order>>;
    final framesResult = results[1] as Either<FrameFailure, List<Frame>>;
    final accessoriesResult =
        results[2] as Either<AccessoryFailure, List<Accessory>>;

    final orders = ordersResult.fold((_) => <Order>[], (r) => r);
    final frames = framesResult.fold((_) => <Frame>[], (r) => r);
    final accessories = accessoriesResult.fold((_) => <Accessory>[], (r) => r);

    bool hasOrderError = ordersResult.fold((_) => true, (_) => false);

    if (hasOrderError) {
      emit(state.copyWith(status: DashboardStatus.failure));
      return;
    }

    final today = DateTime.now();

    final dailyTotal = orders
        .where((o) => _isSameDay(o.createdAt, today))
        .fold(0.0, (sum, o) => sum + o.totalAmount.value);

    final totalPendingPayments = orders.fold(0.0, (sum, o) {
      if (o.status != OrderStatus.cancelled) {
        return sum + (o.totalAmount.value - o.paidAmount.value);
      }
      return sum;
    });

    int lowStockCount = 0;

    lowStockCount += frames.where((frame) {
      final totalStock = frame.variants.fold<int>(
        0,
        (sum, v) => sum + v.quantity,
      );
      return totalStock < 5;
    }).length;

    lowStockCount += accessories.where((a) => a.quantity < 5).length;

    final List<double> weeklySummary = List.generate(7, (index) {
      final targetDate = today.subtract(Duration(days: 6 - index));

      return orders
          .where((o) => _isSameDay(o.createdAt, targetDate))
          .fold(0.0, (sum, o) => sum + o.totalAmount.value);
    });

    emit(
      state.copyWith(
        status: DashboardStatus.success,
        lowStockCount: lowStockCount,
        weeklySalesData: weeklySummary,
      ),
    );
  }

  bool _isSameDay(DateTime d1, DateTime d2) =>
      d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;

  @override
  Future<void> close() {
    _activitySubscription?.cancel();
    _orderCountSubscription?.cancel();
    return super.close();
  }
}

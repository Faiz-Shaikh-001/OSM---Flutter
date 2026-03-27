part of 'dashboard_bloc.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final Money dailySales;
  final int activeOrderCount;
  final int lowStockCount;
  final List<Activity> recentActivities;
  final List<double> weeklySalesData;
  final String? errorMessage;
  final Money pendingPayments;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.dailySales = const Money(0),
    this.activeOrderCount = 0,
    this.lowStockCount = 0,
    this.recentActivities = const [],
    this.weeklySalesData = const [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
    this.pendingPayments = const Money(0),
    this.errorMessage,
  });

  DashboardState copyWith({
    DashboardStatus? status,
    Money? dailySales,
    int? activeOrderCount,
    int? lowStockCount,
    List<Activity>? recentActivities,
    List<double>? weeklySalesData,
    Money? pendingPayments,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      dailySales: dailySales ?? this.dailySales,
      activeOrderCount: activeOrderCount ?? this.activeOrderCount,
      lowStockCount: lowStockCount ?? this.lowStockCount,
      recentActivities: recentActivities ?? this.recentActivities,
      weeklySalesData: weeklySalesData ?? this.weeklySalesData,
      pendingPayments: pendingPayments ?? this.pendingPayments,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    dailySales,
    activeOrderCount,
    lowStockCount,
    recentActivities,
    weeklySalesData,
    pendingPayments,
    errorMessage,
  ];
}

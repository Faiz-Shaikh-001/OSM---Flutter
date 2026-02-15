part of 'dashboard_bloc.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final double dailySales;
  final int activeOrdersCount;
  final int lowStockCount;
  final List<Activity> recentActivities;
  final List<double> weeklySalesData;
  final String? errorMessage;
  final double pendingPayments;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.dailySales = 0.0,
    this.activeOrdersCount = 0,
    this.lowStockCount = 0,
    this.recentActivities = const [],
    this.weeklySalesData = const [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
    this.pendingPayments = 0.0,
    this.errorMessage,
  });

  DashboardState copyWith({
    DashboardStatus? status,
    double? dailySales,
    int? activeOrdersCount,
    int? lowStockCount,
    List<Activity>? recentActivities,
    List<double>? weeklySalesData,
    double? pendingPayments,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      dailySales: dailySales ?? this.dailySales,
      activeOrdersCount: activeOrdersCount ?? this.activeOrdersCount,
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
    activeOrdersCount,
    lowStockCount,
    recentActivities,
    weeklySalesData,
    pendingPayments,
    errorMessage,
  ];
}


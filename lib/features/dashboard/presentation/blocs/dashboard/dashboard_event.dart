part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class DashboardStarted extends DashboardEvent {}

class DashboardRefreshRequested extends DashboardEvent {}

class DashboardStoreChanged extends DashboardEvent {
  final String storeId;
  const DashboardStoreChanged(this.storeId);

  @override
  List<Object?> get props => [storeId];
}

class DashboardDataUpdated extends DashboardEvent {
  final List<Activity>? activities;
  final int? activeOrderCount;
  final Money? pendingPayments;
  final Money? todaysSale;

  const DashboardDataUpdated({
    this.activities,
    this.activeOrderCount,
    this.pendingPayments,
    this.todaysSale,
  });

  @override
  List<Object?> get props => [
    activities,
    activeOrderCount,
    pendingPayments,
    todaysSale,
  ];
}

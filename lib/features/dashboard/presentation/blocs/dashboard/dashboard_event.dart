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
  final int? activeOrdersCount;

  const DashboardDataUpdated({this.activities, this.activeOrdersCount});

  @override
  List<Object?> get props => [activities, activeOrdersCount];
}
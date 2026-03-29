import 'package:meta/meta.dart';
import 'package:osm/features/staff/domain/entities/staff.dart';

@immutable
sealed class StaffState {}

class StaffInitial extends StaffState {}

class StaffLoading extends StaffState {}

class StaffLoaded extends StaffState {
  final List<Staff> staff;

  StaffLoaded(this.staff);
}

class StaffError extends StaffState {
  final String message;

  StaffError(this.message);
}
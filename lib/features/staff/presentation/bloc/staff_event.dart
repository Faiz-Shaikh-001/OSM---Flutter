import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/staff/domain/entities/staff.dart';

abstract class StaffEvent {}

class LoadStaff extends StaffEvent {
  final StoreLocationId storeId;

  LoadStaff({required this.storeId});
}

class AddStaffEvent extends StaffEvent {
  final Staff staff;

  AddStaffEvent(this.staff);
}

class UpdateStaffEvent extends StaffEvent {
  final Staff staff;

  UpdateStaffEvent(this.staff);
}

class DeleteStaffEvent extends StaffEvent {
  final StaffId id;

  DeleteStaffEvent(this.id);
}
import 'package:isar/isar.dart';

part 'staff_model.g.dart';
@collection
class StaffModel {
  Id id = Isar.autoIncrement;

  late String name;
  late String phone;
  late String email;
  late String role;

  late int storeId;   // must be INT

  late bool isActive;
  late DateTime createdAt;
}
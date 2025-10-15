import 'package:isar/isar.dart';

part 'staff_model.g.dart';

@Collection()
class Staff {
  Id id = Isar.autoIncrement;

  late String name;
  late String email;

  @Enumerated(EnumType.name) // Stores the role as a string (e.g., 'admin')
  late StaffRole role;
}

// Using an enum for roles is best practice.
// Values have been changed to lowerCamelCase to follow Dart's style guide.
enum StaffRole {
  admin,
  manager,
  cashier,
}


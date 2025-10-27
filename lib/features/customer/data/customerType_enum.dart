import 'package:isar/isar.dart';

@Enumerated(EnumType.name)
enum CustomerType {
  walkIn,
  returning,
  vip,
  corporate,
  staff
}

extension CustomerTypeLabel on CustomerType {
  String get label {
    switch (this) {
      case CustomerType.walkIn:
        return "Walk In";
      case CustomerType.returning:
        return "Returning";
      case CustomerType.vip:
        return "VIP";
      case CustomerType.corporate:
        return "Corporate";
      case CustomerType.staff:
        return "Staff";
    }
  }
}
import 'package:isar/isar.dart';

part 'recent_activities.g.dart';

@Enumerated(EnumType.name)
enum ActivityType {
  newOrder,
  paymentReceived,
  lowStockAlert,
  stockUpdated,
  newStockAdded,
  newCustomerAdded,
  customerUpdated,
  customerDeleted,
}

@collection
class ActivityModel {
  Id id = Isar.autoIncrement;
  
  @Enumerated(EnumType.name)
  ActivityType type;
  String title;
  String subtitle;
  DateTime time;

  ActivityModel({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.time,
  });
}

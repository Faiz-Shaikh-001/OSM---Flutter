import 'package:isar/isar.dart';
import 'package:osm/features/dashboard/domain/entities/activity.dart';
import 'dart:convert';

part 'activity_model.g.dart';

@collection
class ActivityModel {
  Id isarId = Isar.autoIncrement;

  late int? activityId;

  @Enumerated(EnumType.name)
  late ActivityType type;
  late DateTime occurredAt;
  late String metadataJson;

  ActivityModel();
  factory ActivityModel.fromEntity(Activity activity) {
    return ActivityModel()
      ..activityId = activity.id
      ..type = activity.type
      ..occurredAt = activity.occurredAt
      ..metadataJson = json.encode(activity.metadata);
  }

  Activity toEntity() {
    return Activity(
      id: activityId,
      type: type,
      occurredAt: occurredAt,
      metadata: json.decode(metadataJson) as Map<String, dynamic>,
    );
  }
}

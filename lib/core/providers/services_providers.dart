import 'package:osm/core/services/isar_service.dart';
import 'package:provider/provider.dart';

final List<Provider> servicesProvider = [
  Provider<IsarService>(create: (_) => IsarService()),
];

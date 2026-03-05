import 'package:osm/features/dashboard/presentation/models/search_results_ui_model.dart';

class SearchResult {
  final SearchResultType type;
  final String title;
  final String subtitle;
  final Object reference;

  SearchResult({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.reference,
  });
}

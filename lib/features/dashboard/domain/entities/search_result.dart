enum SearchResultType { order, customer, lens, frame, accessory, doctor }

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

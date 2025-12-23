class SearchQuery {
  final String value;

  const SearchQuery(this.value);

  bool get isEmpty => value.trim().isEmpty;
}
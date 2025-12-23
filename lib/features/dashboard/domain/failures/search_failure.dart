abstract class SearchFailure {
  final String message;
  const SearchFailure(this.message);
}

class SearchUnavailableFailure extends SearchFailure {
  const SearchUnavailableFailure() : super('Search is currently unavailable');
}

class SearchUnknownFailure extends SearchFailure {
  const SearchUnknownFailure() : super('Unexpected search error');
}

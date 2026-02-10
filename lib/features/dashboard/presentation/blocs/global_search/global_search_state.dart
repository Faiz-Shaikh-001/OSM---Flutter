part of 'global_search_bloc.dart';

@immutable
sealed class GlobalSearchState { const GlobalSearchState(); }

final class GlobalSearchInitial extends GlobalSearchState {}

class GlobalSearchLoading extends GlobalSearchState {}

class GlobalSearchLoaded extends GlobalSearchState {
  final List<SearchResultUiModel> results;
  const GlobalSearchLoaded(this.results);
}

class GlobalSearchEmpty extends GlobalSearchState {}

class GlobalSearchError extends GlobalSearchState {
  final String message;
  const GlobalSearchError(this.message);
}

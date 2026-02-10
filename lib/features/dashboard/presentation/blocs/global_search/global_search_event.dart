part of 'global_search_bloc.dart';

@immutable
sealed class GlobalSearchEvent {
  const GlobalSearchEvent();
}

class LoadSearchData extends GlobalSearchEvent {}

class QueryChanged extends GlobalSearchEvent {
  final String query;

  const QueryChanged(this.query);
}

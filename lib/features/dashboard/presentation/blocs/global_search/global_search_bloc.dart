import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:osm/features/dashboard/presentation/models/search_results_ui_model.dart';

part 'global_search_event.dart';
part 'global_search_state.dart';

class GlobalSearchBloc extends Bloc<GlobalSearchEvent, GlobalSearchState> {
  final List<SearchResultUiModel> _allItems = [];

  GlobalSearchBloc() : super(GlobalSearchInitial()) {
    on<LoadSearchData>(_onLoadData);
    on<QueryChanged>(_onQueryChanged);
  }

  Future<void> _onLoadData(
    LoadSearchData event,
    Emitter<GlobalSearchState> emit,
  ) async {
    emit(GlobalSearchLoading());

    try {
      emit(GlobalSearchLoaded(_allItems));
    } catch (e) {
      emit(const GlobalSearchError('Failed to load search data'));
    }
  }

  void _onQueryChanged(QueryChanged event, Emitter<GlobalSearchState> emit) {
    if (event.query.isEmpty) {
      emit(GlobalSearchEmpty());
      return;
    }

    final filtered = _allItems.where((item) {
      return item.title.toLowerCase().contains(event.query.toLowerCase());
    }).toList();

    emit(filtered.isEmpty ? GlobalSearchEmpty() : GlobalSearchLoaded(filtered));
  }
}

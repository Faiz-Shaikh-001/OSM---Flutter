import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osm/features/dashboard/application/search/search_everything.dart';
import 'package:osm/features/dashboard/domain/entities/search_result.dart';
import 'package:osm/features/dashboard/domain/value_objects/search_query.dart';
import 'package:osm/features/dashboard/presentation/models/search_results_ui_model.dart';

part 'global_search_event.dart';
part 'global_search_state.dart';

class GlobalSearchBloc extends Bloc<GlobalSearchEvent, GlobalSearchState> {
  final SearchEverything _searchEverything;

  GlobalSearchBloc({required SearchEverything searchEverything})
    : _searchEverything = searchEverything,
      super(GlobalSearchInitial()) {
    on<QueryChanged>(_onQueryChanged);
  }

  Future<void> _onQueryChanged(
    QueryChanged event,
    Emitter<GlobalSearchState> emit,
  ) async {
    emit(GlobalSearchLoading());

    final result = await _searchEverything(SearchQuery(event.query));

    result.fold(
      (failure) =>
          emit(const GlobalSearchError("Failed to fetch search results")),
      (results) {
        if (results.isEmpty) {
          emit(GlobalSearchEmpty());
        } else {
          final uiModels = results.map((res) => _mapToUiModel(res)).toList();
          emit(GlobalSearchLoaded(uiModels));
        }
      },
    );
  }

  SearchResultUiModel _mapToUiModel(SearchResult res) {
    return SearchResultUiModel(
      title: res.title,
      subtitle: res.subtitle,
      type: res.type,
      icon: _getIconForType(res.type),
      payload: res.reference,
    );
  }

  IconData _getIconForType(SearchResultType type) {
    switch (type) {
      case SearchResultType.order: return Icons.receipt_long;
      case SearchResultType.frame: return CupertinoIcons.eyeglasses;
      case SearchResultType.lens: return Icons.lens;
      case SearchResultType.accessory: return Icons.luggage;
      case SearchResultType.customer: return Icons.person;
      case SearchResultType.doctor: return Icons.medical_services;
    }
  }
}

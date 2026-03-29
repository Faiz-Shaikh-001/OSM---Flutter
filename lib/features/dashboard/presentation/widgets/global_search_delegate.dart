import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/dashboard/presentation/blocs/global_search/global_search_bloc.dart';
import 'package:osm/features/dashboard/presentation/models/search_results_ui_model.dart';

class GlobalSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search orders, products...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            context.read<GlobalSearchBloc>().add(const QueryChanged(''));
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    context.read<GlobalSearchBloc>().add(QueryChanged(query));
    return _buildBody();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    context.read<GlobalSearchBloc>().add(QueryChanged(query));
    return _buildBody();
  }

  Widget _buildBody() {
    return BlocBuilder<GlobalSearchBloc, GlobalSearchState>(
      builder: (context, state) {
        if (state is GlobalSearchLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GlobalSearchEmpty) {
          return const Center(child: Text('No results found'));
        }

        if (state is GlobalSearchLoaded) {
          return ListView.builder(
            itemCount: state.results.length,
            itemBuilder: (_, idx) {
              final item = state.results[idx];

              return ListTile(
                leading: Icon(item.icon),
                title: Text(item.title),
                subtitle: Text(item.subtitle),
                onTap: () => _handleNavigation(context, item),
              );
            },
          );
        }

        if (state is GlobalSearchError) {
          return Center(child: Text(state.message));
        }

        return const Center(child: Text('Type to search...'));
      },
    );
  }

  void _handleNavigation(BuildContext context, SearchResultUiModel item) {
    close(context, item);
  }
}

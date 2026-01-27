import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/orders/presentation/blocs/product_search/product_search_bloc.dart';
import 'package:osm/features/orders/presentation/screens/product_step/widgets/product_search_result_tile.dart';

class ProductSearchResultsView extends StatelessWidget {
  const ProductSearchResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductSearchBloc, ProductSearchState>(
      builder: (context, state) {
        if (state is ProductSearchLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProductSearchEmpty) {
          return const Center(child: Text('No products found'));
        }

        if (state is ProductSearchError) {
          return Center(child: Text(state.message));
        }

        if (state is ProductSearchLoaded) {
          return ListView.builder(
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              return ProductSearchTile(result: state.results[index]);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

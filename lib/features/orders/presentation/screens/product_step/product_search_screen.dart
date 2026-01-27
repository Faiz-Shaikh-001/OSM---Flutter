import 'package:flutter/material.dart';
import 'package:osm/features/orders/presentation/screens/product_step/widgets/product_search_bar.dart';
import 'package:osm/features/orders/presentation/screens/product_step/widgets/product_search_results_view.dart';

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Products')),
      body: Column(
        children: const [
          ProductSearchBar(),
          Expanded(child: ProductSearchResultsView()),
        ],
      ),
    );
  }
}

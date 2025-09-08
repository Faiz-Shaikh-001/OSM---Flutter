import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class ProductSearchDelegate extends SearchDelegate<Product?> {
  final List<Product> searchableProducts;

  ProductSearchDelegate({required this.searchableProducts});

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Action button to clear the search query
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Back button to close the search
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null), // Close and return null
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show results based on the final query
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    if (query.isEmpty) {
      return const Center(
        child: Text(
          "Start typing to search products...",
          style: TextStyle(fontSize: 16),
        ),
      );
    }
    final lowerQuery = query.toLowerCase();
    final results = searchableProducts.where((product) {
      return product.name.toLowerCase().contains(lowerQuery) ||
          product.id.contains(query);
    }).toList();

    if (results.isEmpty) {
      for (var searchableProduct in searchableProducts) {
        debugPrint("==>==$searchableProduct\n\n\n");
      }
      return const Center(
        child: Text(
          "No matching products found",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text('ID: ${product.id}'),
          onTap: () {
            // Close the search and return the selected product
            close(context, product);
          },
        );
      },
    );
  }
}

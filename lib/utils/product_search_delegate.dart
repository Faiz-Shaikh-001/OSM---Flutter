import 'package:flutter/material.dart';
import '../data/models/product_model.dart';

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
    final lowerQuery = query.toLowerCase();
    final results = searchableProducts.where((product) {
      return product.name.toLowerCase().contains(lowerQuery) ||
          product.id.contains(query);
    }).toList();

    return ListView.builder(
      itemCount: results.length,
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

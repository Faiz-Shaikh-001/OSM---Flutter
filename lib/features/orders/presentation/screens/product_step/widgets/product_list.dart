import 'package:flutter/material.dart';
import 'package:osm/features/inventory/data/models/product_model.dart';
import 'product_card.dart';

class ProductList extends StatelessWidget {
  final Map<Product, int> products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final entries = products.entries.toList();
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // looks more like a catalog
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final product = entries[index].key;
        final quantity = entries[index].value;
        return ProductCard(product: product, quantity: quantity);
      },
    );
  }
}

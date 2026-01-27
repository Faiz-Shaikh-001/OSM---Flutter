import 'package:flutter/material.dart';
import 'package:osm/features/orders/domain/entities/order_item.dart';
// import 'product_card.dart';

class ProductListView extends StatelessWidget {
  final List<OrderItem> items;
  final VoidCallback onSearch;
  const ProductListView({
    super.key,
    required this.items,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final entries = items;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: onSearch,
        child: const Icon(Icons.add),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // looks more like a catalog
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final product = entries[index];
          final quantity = entries[index].quantity;
          return Card(child: Text("$quantity $product card"));
          // return ProductCard(product: product, quantity: quantity);
        },
      ),
    );
  }
}

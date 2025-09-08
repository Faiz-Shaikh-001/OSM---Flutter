import 'package:flutter/material.dart';
import 'package:osm/features/inventory/data/models/product_model.dart';
import 'action_buttons.dart';

class EmptyStateView extends StatelessWidget {
  final List<Product> allProducts;
  const EmptyStateView({super.key, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_basket_outlined,
            size: 60,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'Your order is empty',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'Scan or search for a product to add it.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ActionButtons(allProducts: allProducts),
        ],
      ),
    );
  }
}

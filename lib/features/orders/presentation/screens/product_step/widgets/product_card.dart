import 'package:flutter/material.dart';
import 'package:osm/features/orders/domain/entities/order_item.dart';
import 'package:provider/provider.dart';
import 'quantity_stepper.dart';

class ProductCard extends StatelessWidget {
  final OrderItem product;
  final int quantity;
  const ProductCard({super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainer,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '₹${product.price.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: quantity == 0
                ? FilledButton.tonal(
                    onPressed: () => viewModel.addProduct(product),
                    child: const Text('Add'),
                  )
                : QuantityStepper(product: product, quantity: quantity),
          ),
        ],
      ),
    );
  }
}

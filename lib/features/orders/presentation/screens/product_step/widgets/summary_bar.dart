import 'package:flutter/material.dart';
import 'package:osm/features/inventory/data/models/product_model.dart';
import 'package:osm/features/orders/viewmodel/order_viewmodel.dart';
import 'package:provider/provider.dart';
import 'action_buttons.dart';

class SummaryBar extends StatelessWidget {
  final VoidCallback onNext;
  final List<Product> allProducts;

  const SummaryBar({
    super.key,
    required this.onNext,
    required this.allProducts,
  });

  @override
  Widget build(BuildContext context) {
    final orderViewModel = context.watch<OrderViewModel>();

    return Card(
      margin: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (orderViewModel.selectedProducts.isNotEmpty) ...[
              ActionButtons(allProducts: allProducts),
              const SizedBox(height: 16),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${orderViewModel.totalItems} Items',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Total: ₹${orderViewModel.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                FilledButton(
                  onPressed: orderViewModel.totalItems > 0 ? onNext : null,
                  child: const Text('Proceed to Payment'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

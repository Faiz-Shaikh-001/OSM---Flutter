import 'package:flutter/material.dart';
import 'package:osm/features/orders/domain/entities/order_item.dart';
import 'package:osm/features/orders/presentation/screens/product_step/widgets/action_buttons.dart';
import 'package:osm/features/orders/presentation/screens/product_step/widgets/product_card.dart';
import 'package:osm/features/orders/presentation/screens/product_step/widgets/summary_bar.dart';
// import 'product_card.dart';

class ProductListView extends StatelessWidget {
  final List<OrderItem> items;
  final VoidCallback onSearch;
  final VoidCallback onScan;
  final VoidCallback onNext;
  const ProductListView({
    super.key,
    required this.items,
    required this.onSearch,
    required this.onScan,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final entries = items;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final product = entries[index];
                return ProductCard(product: product);
              },
            ),
          ),
          ActionButtons(onScan: onScan, onSearch: onSearch),
          SummaryBar(onNext: onNext),
        ],
      ),
    );
  }
}

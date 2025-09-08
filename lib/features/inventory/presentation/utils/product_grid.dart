import 'package:flutter/material.dart';
import 'package:osm/core/utils/product_type.dart';
import 'package:osm/core/widgets/grid_card.dart';

class ProductGrid extends StatelessWidget {
  final List<dynamic> products;
  final ProductType productType;
  final VoidCallback onRefresh;

  const ProductGrid({
    super.key,
    required this.products,
    required this.productType,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('No products to display.'));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: .8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return GridCard(
          heroIndex: index,
          product: product,
          productType: productType,
        );
      },
    );
  }
}

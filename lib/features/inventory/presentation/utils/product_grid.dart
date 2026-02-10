import 'package:flutter/material.dart';
import 'package:osm/core/utils/product_type.dart';
import 'package:osm/core/widgets/grid_card.dart';

class ProductGrid<T extends Object> extends StatelessWidget {
  final List<T> products;
  final ProductType productType;
  final VoidCallback onRefresh;
  final ValueChanged<Object> onTap;
  final ValueChanged<Object> onLongPress;

  const ProductGrid({
    super.key,
    required this.products,
    required this.productType,
    required this.onRefresh,
    required this.onLongPress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      physics: const AlwaysScrollableScrollPhysics(),
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
          product: product,
          productType: productType,
          onTap: () => onTap(product),
          onLongPress: () => onLongPress(product),
        );
      },
    );
  }
}

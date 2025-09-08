import 'package:flutter/material.dart';
import 'package:osm/features/inventory/data/models/product_model.dart';
import 'package:osm/features/orders/viewmodel/order_viewmodel.dart';
import 'package:provider/provider.dart';

class QuantityStepper extends StatelessWidget {
  final Product product;
  final int quantity;
  const QuantityStepper({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final orderViewModel = context.read<OrderViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.filledTonal(
          icon: const Icon(Icons.remove),
          onPressed: () => orderViewModel.removeProduct(product),
        ),
        SizedBox(
          width: 40,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton.filledTonal(
          icon: const Icon(Icons.add),
          onPressed: () => orderViewModel.addProduct(product),
        ),
      ],
    );
  }
}

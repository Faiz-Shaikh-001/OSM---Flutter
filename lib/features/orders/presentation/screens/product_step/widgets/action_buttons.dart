import 'package:flutter/material.dart';
import 'package:osm/features/inventory/data/models/product_model.dart';
import 'package:osm/features/inventory/presentation/utils/product_search_delegate.dart';
import 'package:osm/features/scanner/presentation/screens/scanner_screen.dart';
import 'package:osm/features/orders/viewmodel/order_viewmodel.dart';
import 'package:provider/provider.dart';

class ActionButtons extends StatelessWidget {
  final List<Product> allProducts;
  const ActionButtons({super.key, required this.allProducts});

  void _handleScannedCode(BuildContext context, String scannedCode) {
    final orderViewModel = context.read<OrderViewModel>();
    try {
      final product = allProducts.firstWhere((p) => p.id == scannedCode);
      orderViewModel.addProduct(product);
    } catch (_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Product not found!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.qr_code_scanner),
          label: const Text('Scan Product'),
          onPressed: () async {
            final scannedCode = await Navigator.of(context).push<String>(
              MaterialPageRoute(builder: (c) => const ScannerScreen()),
            );
            if (scannedCode != null && context.mounted) {
              _handleScannedCode(context, scannedCode);
            }
          },
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.search),
          label: const Text('Search'),
          onPressed: () async {
            final selectedProduct = await showSearch<Product?>(
              context: context,
              delegate: ProductSearchDelegate(searchableProducts: allProducts),
            );
            if (context.mounted && selectedProduct != null) {
              context.read<OrderViewModel>().addProduct(selectedProduct);
            }
          },
        ),
      ],
    );
  }
}

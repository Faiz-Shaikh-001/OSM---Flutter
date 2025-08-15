import 'package:flutter/material.dart';
import 'package:osm/data/models/product_model.dart';
import 'package:osm/utils/product_search_delegate.dart';
import 'package:osm/utils/product_type.dart';
import 'package:osm/utils/scanner_screen.dart';
import 'package:osm/viewmodels/order_viewmodel.dart';
import 'package:provider/provider.dart';

class ProductSelectionStep extends StatelessWidget {
  final VoidCallback onNext;
  const ProductSelectionStep({super.key, required this.onNext});

  // Dummy data for searching/scanning lookup. In a real app, this would come from a database.
  static final List<Product> _allProducts = [
    Product(
      id: '8901234567890',
      name: 'Aviator Gold',
      price: 4500,
      imageUrl: '',
      category: ProductType.frame,
    ),
    Product(
      id: '8902345678901',
      name: 'Wayfarer Black',
      price: 3200,
      imageUrl: '',
      category: ProductType.frame,
    ),
    Product(
      id: '8903456789012',
      name: 'Anti-Glare Lenses',
      price: 1800,
      imageUrl: '',
      category: ProductType.frame,
    ),
    Product(
      id: '8904567890123',
      name: 'Blue-Cut Lenses',
      price: 2500,
      imageUrl: '',
      category: ProductType.frame,
    ),
    Product(
      id: '8905678901234',
      name: 'Classic Sunglasses',
      price: 5500,
      imageUrl: '',
      category: ProductType.frame,
    ),
  ];

  // Method to handle the result from the scanner screen
  void _handleScannedCode(BuildContext context, String scannedCode) {
    final orderViewModel = context.read<OrderViewModel>();
    try {
      final product = _allProducts.firstWhere((p) => p.id == scannedCode);
      orderViewModel.addProduct(product);
    } catch (e) {
      // Show an error if the barcode is not found in our product list
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Product not found!')));
    }
  }

  // Method to handle the result from the search delegate
  void _handleSearchedProduct(BuildContext context, Product? product) {
    if (product != null) {
      context.read<OrderViewModel>().addProduct(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderViewModel = context.watch<OrderViewModel>();

    return Column(
      children: [
        // List of currently selected products
        Expanded(
          child: orderViewModel.selectedProducts.isEmpty
              ? _buildEmptyState(context)
              : _buildSelectedProductsList(orderViewModel),
        ),

        // Summary Bar and Proceed Button
        _buildSummaryBar(context, orderViewModel),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
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
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildSelectedProductsList(OrderViewModel orderViewModel) {
    final products = orderViewModel.selectedProducts.entries.toList();

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index].key;
        final quantity = products[index].value;
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.inventory_2_outlined,
                  size: 40,
                  color: Colors.grey,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '₹${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                _buildQuantityStepper(context, product, quantity),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuantityStepper(
    BuildContext context,
    Product product,
    int quantity,
  ) {
    final orderViewModel = context.read<OrderViewModel>();
    return Row(
      children: [
        IconButton.filledTonal(
          icon: const Icon(Icons.remove),
          onPressed: () => orderViewModel.removeProduct(product),
          visualDensity: VisualDensity.compact,
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
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
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
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.search),
          label: const Text('Search'),
          onPressed: () async {
            final selectedProduct = await showSearch<Product?>(
              context: context,
              delegate: ProductSearchDelegate(searchableProducts: _allProducts),
            );
            if (context.mounted) {
              _handleSearchedProduct(context, selectedProduct);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryBar(BuildContext context, OrderViewModel orderViewModel) {
    return Card(
      margin: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Only show action buttons here if the list is not empty
            if (orderViewModel.selectedProducts.isNotEmpty)
              _buildActionButtons(context),
            if (orderViewModel.selectedProducts.isNotEmpty)
              const SizedBox(height: 16),
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

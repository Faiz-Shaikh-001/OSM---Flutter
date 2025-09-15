import 'package:flutter/material.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/features/orders/data/repositories/product_repository.dart';
import 'package:provider/provider.dart';
import 'package:osm/features/inventory/data/models/product_model.dart';
import 'package:osm/features/orders/viewmodel/order_viewmodel.dart';

import 'widgets/empty_state_view.dart';
import 'widgets/product_list.dart';
import 'widgets/summary_bar.dart';

class ProductSelectionStep extends StatefulWidget {
  final VoidCallback onNext;
  const ProductSelectionStep({super.key, required this.onNext});

  @override
  State<ProductSelectionStep> createState() => _ProductSelectionStepState();
}

class _ProductSelectionStepState extends State<ProductSelectionStep> {
  late final ProductRepository _productRepository;
  List<Product> _allProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    _productRepository = ProductRepository(IsarService());
    _loadProducts();
    super.initState();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _productRepository.getAllProducts();

      debugPrint("\n\n\nProducts: $products \n\n\n");

      setState(() {
        _allProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loading products: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderViewModel = context.watch<OrderViewModel>();

    return Column(
      children: [
        Expanded(
          child: orderViewModel.selectedProducts.isEmpty
              ? EmptyStateView(allProducts: _allProducts)
              : ProductList(products: orderViewModel.selectedProducts),
        ),
        SummaryBar(onNext: widget.onNext, allProducts: _allProducts),
      ],
    );
  }
}

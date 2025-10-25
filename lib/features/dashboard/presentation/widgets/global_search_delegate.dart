import 'package:flutter/material.dart';
import 'package:osm/core/utils/product_type.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/customer/data/customer_repository.dart';
import 'package:osm/features/customer/presentation/screens/customer_details_screen.dart';
import 'package:osm/features/inventory/data/models/frame_model.dart';
import 'package:osm/features/inventory/data/models/lens_model.dart';
import 'package:osm/features/inventory/data/repositories/frame_repository.dart';
import 'package:osm/features/inventory/data/repositories/lens_repository.dart';
import 'package:osm/features/inventory/presentation/screens/item_screen.dart';
import 'package:osm/features/orders/data/models/order_model.dart';
import 'package:osm/features/orders/data/repositories/order_repository.dart';
import 'package:osm/features/orders/presentation/screens/order_detail_screen/order_detail_screen.dart';

class GlobalSearchDelegate extends SearchDelegate {
  List<dynamic> _allData = [];
  final LensRepository _lensRepository;
  final FrameRepository _frameRepository;
  final OrderRepository _orderRepository;
  final CustomerRepository _customerRepository;

  GlobalSearchDelegate(
    this._lensRepository,
    this._frameRepository,
    this._orderRepository,
    this._customerRepository,
  ) {
    _fetchAllData();
  }

  @override
  String get searchFieldLabel => 'Search orders, products...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text("Type to search..."));
    }
    final filtered = _allData.where((item) {
      final name =
          (item['name'] ?? item['product_name'] ?? item['order_id'] ?? '')
              .toString()
              .toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    return _buildResultsList(filtered);
  }

  @override
  Widget buildResults(BuildContext context) {
    final filtered = _allData.where((item) {
      final name =
          (item['name'] ?? item['product_name'] ?? item['order_id'] ?? '')
              .toString()
              .toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    return _buildResultsList(filtered);
  }

  Widget _buildResultsList(List<dynamic> results) {
    if (results.isEmpty) {
      return const Center(child: Text('No results found'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: const Icon(Icons.inventory_2),
          title: Text(item['name'] ?? item['product_name'] ?? 'Unnamed item'),
          subtitle: Text(item['type'] ?? ''),
          onTap: () {
            // Navigate to detailed page if needed
            if (item['model'] is OrderModel) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderDetailsScreen(order: item['model']),
                ),
              );
            } else if (item['model'] is FrameModel) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ItemPage(
                    product: item['model'],
                    productType: ProductType.frame,
                    heroIndex: 0, // default if opening from search
                  ),
                ),
              );
            } else if (item['model'] is LensModel) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ItemPage(
                    product: item['model'],
                    productType: ProductType.lens,
                    heroIndex: 0,
                  ),
                ),
              );
            } else if (item['model'] is CustomerModel) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CustomerDetailsScreen(customer: item['model']),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Unknown item type')),
              );
            }
          },
        );
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    if (_allData.isEmpty) {
      _fetchAllData(); // fetch only once
    }
    super.showResults(context);
  }

  Future<void> _fetchAllData() async {
    // Call your API endpoints here
    final List<OrderModel> orders = await _orderRepository.getAll();
    final List<FrameModel> frames = await _frameRepository.getAll();
    final List<LensModel> lenses = await _lensRepository.getAll();
    final List<CustomerModel> customers = await _customerRepository.getAll();

    for (var order in orders) {
      await order.customer.load();
    }

    _allData = [
      ...orders.map(
        (o) => {
          'name': o.customer.value?.firstName ?? 'Order #${o.id}',
          'order_id': o.id,
          'type': 'Order',
          'model': o,
        },
      ),
      ...frames.map(
        (f) => {
          'name': f.name,
          'product_name': f.name,
          'type': 'Frame',
          'model': f,
        },
      ),
      ...lenses.map(
        (l) => {
          'name': l.companyName,
          'product_name': l.productName,
          'type': 'Lens',
          'model': l,
        },
      ),
      ...customers.map(
        (c) => {'name': c.firstName, 'type': 'Customer', 'model': c},
      ),
    ];
  }
}

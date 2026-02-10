// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/services/isar_service.dart';
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/dashboard/data/sources/accessory_search_source.dart';
import 'package:osm/features/dashboard/data/sources/frame_search_source.dart';
import 'package:osm/features/dashboard/data/sources/lens_search_source.dart';
import 'package:osm/features/dashboard/data/sources_impl/accessory_search_source_impl.dart';
import 'package:osm/features/dashboard/data/sources_impl/frame_search_source_impl.dart';
import 'package:osm/features/dashboard/data/sources_impl/lens_search_source_impl.dart';
import 'package:osm/features/orders/domain/entities/order_item.dart';
import 'package:osm/features/orders/presentation/blocs/order_draft/order_draft_bloc.dart';
import 'package:osm/features/orders/presentation/blocs/product_search/product_search_bloc.dart';
import 'package:osm/features/orders/presentation/screens/product_step/product_search_screen.dart';
import 'package:osm/features/orders/presentation/screens/product_step/widgets/quantity_capsule.dart';
import 'package:osm/features/scanner/presentation/screens/scanner_screen.dart';
import 'package:provider/provider.dart';

class ProductStep extends StatelessWidget {
  final VoidCallback onNext;

  const ProductStep({super.key, required this.onNext});

  void _onSearch(BuildContext context) {
    final orderDraftBloc = context.read<OrderDraftBloc>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiProvider(
          providers: [
            Provider<AccessorySearchSource>(
              create: (context) =>
                  AccessorySearchSourceImpl(context.read<IsarService>()),
            ),
            Provider<FrameSearchSource>(
              create: (context) =>
                  FrameSearchSourceImpl(context.read<IsarService>()),
            ),
            Provider<LensSearchSource>(
              create: (context) =>
                  LensSearchSourceImpl(context.read<IsarService>()),
            ),
            BlocProvider(
              create: (context) => ProductSearchBloc(
                frameSearch: context.read<FrameSearchSource>(),
                lensSearch: context.read<LensSearchSource>(),
                accessorySearch: context.read<AccessorySearchSource>(),
              ),
            ),
            BlocProvider.value(value: orderDraftBloc),
          ],
          child: const ProductSearchScreen(),
        ),
      ),
    );
  }

  void _onScan(BuildContext context) async {
    final scannedCode = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const ScannerScreen()),
    );

    if (scannedCode != null && context.mounted) {
      try {
        context.read<ProductSearchBloc>().add(
          ProductSearchQrScanned(scannedCode),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Scanner logic need ProductSearchBloc provider upstream",
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDraftBloc, OrderDraftState>(
      builder: (context, state) {
        final items = state.draft.items;
        final hasItems = items.isNotEmpty;

        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: hasItems
              ? _buildProductList(context, items)
              : _buildEmptyState(context),

          floatingActionButton: hasItems
              ? FloatingActionButton.extended(
                  onPressed: () => _showAddOptions(context),
                  label: const Text(
                    "Add Item",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 2,
                )
              : null,

          bottomNavigationBar: hasItems
              ? _buildBottomBar(
                  context,
                  items.fold(0, (sum, i) => sum + i.quantity),
                  state.draft.totalAmount,
                )
              : null,
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 64,
                color: Colors.blue[800],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Your Cart is Empty",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Start by adding frames, lenses, or accessories.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),

            const SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: _ActionCard(
                    icon: Icons.qr_code_scanner,
                    label: "Scan Barcode",
                    color: Colors.orange,
                    onTap: () => _onScan(context),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ActionCard(
                    icon: Icons.search,
                    label: "Search Catalog",
                    color: Colors.blue,
                    onTap: () => _onSearch(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(BuildContext context, List<OrderItem> items) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final title = item.productName;
        final subtitle = "Qty: ${item.quantity}";

        return Dismissible(
          key: Key(item.hashCode.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.delete_outline, color: Colors.red),
          ),
          onDismissed: (_) {
            context.read<OrderDraftBloc>().add(ItemRemoved(index));
          },
          child: Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(CupertinoIcons.eyeglasses, color: Colors.grey),
              ),
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(subtitle),
              trailing: QuantityCapsule(
                quantity: item.quantity,
                onIncrement: () {
                  context.read<OrderDraftBloc>().add(
                    ItemQuantityIncreased(item.productID),
                  );
                },
                onDecrement: () {
                  context.read<OrderDraftBloc>().add(
                    ItemQuantityDecreased(item.productID),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomBar(BuildContext context, int count, Money totalAmount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$count Items",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Total: ₹${totalAmount.value.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Next Step"),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add Product",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.qr_code_scanner, color: Colors.orange),
              ),
              title: const Text("Scan Barcode"),
              onTap: () {
                Navigator.pop(ctx);
                _onScan(context);
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.search, color: Colors.blue),
              ),
              title: const Text("Search Catalog"),
              onTap: () {
                Navigator.pop(ctx);
                _onSearch(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

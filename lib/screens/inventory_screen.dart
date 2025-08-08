import 'package:flutter/material.dart';
import 'addStockScreens/add_stock_screen.dart';
import 'package:osm/viewmodels/frame_viewmodel.dart';
import 'package:osm/viewmodels/lens_viewmodel.dart';
import 'package:provider/provider.dart';
import '../widgets/search_bar.dart';
import '../widgets/product_grid.dart';
import '../utils/product_type.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddStockScreen()),
            );
          },
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          tooltip: 'Add Stock',
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Inventory'),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.gpp_good_outlined),
                    SizedBox(width: 5),
                    Text('Frames'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lens_outlined),
                    SizedBox(width: 5),
                    Text('Lenses'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            InventoryTab(productType: ProductType.frame),
            InventoryTab(productType: ProductType.lens),
          ],
        ),
      ),
    );
  }
}

class InventoryTab extends StatefulWidget {
  final ProductType productType;

  const InventoryTab({super.key, required this.productType});
  @override
  State<InventoryTab> createState() => _InventoryTabState();
}

class _InventoryTabState extends State<InventoryTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  // <- Add this.type here
  @override
  void initState() {
    super.initState();
    // addPostFrameCallback to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProducts();
    });
  }

  void _loadProducts() {
    if (widget.productType == ProductType.frame) {
      context.read<FrameViewmodel>().loadFrames();
    } else {
      context.read<LensViewmodel>().loadLenses();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Column(
        children: [
          SearchBarWidget(),
          Expanded(
            child: widget.productType == ProductType.frame
                ? Consumer<FrameViewmodel>(
                    builder: (context, frameViewModel, child) {
                      if (frameViewModel.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (frameViewModel.errorMessage != null) {
                        return Center(
                          child: Text('Error: ${frameViewModel.errorMessage}'),
                        );
                      } else if (frameViewModel.frames.isEmpty) {
                        return const Center(child: Text('No frames found'));
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ProductGrid(
                            products: frameViewModel.frames,
                            productType: ProductType.frame,
                            onRefresh: _loadProducts,
                          ),
                        );
                      }
                    },
                  )
                : Consumer<LensViewmodel>(
                    builder: (context, lensViewModel, child) {
                      if (lensViewModel.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (lensViewModel.errorMessage != null) {
                        return Center(
                          child: Text('Error: ${lensViewModel.errorMessage}'),
                        );
                      } else if (lensViewModel.lens.isEmpty) {
                        return const Center(child: Text('No lenses found'));
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ProductGrid(
                            products: lensViewModel.lens,
                            productType: ProductType.lens,
                            onRefresh: _loadProducts,
                          ),
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

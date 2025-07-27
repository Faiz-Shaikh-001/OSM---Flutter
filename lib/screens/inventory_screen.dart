import 'package:flutter/material.dart';
import 'package:osm/screens/addStockScreens/add_stock_screen.dart';
import '../widgets/search_bar.dart';
import '../widgets/product_grid.dart';

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
        body: const TabBarView(children: [InventoryTab(), InventoryTab()]),
      ),
    );
  }
}

class InventoryTab extends StatelessWidget {
  // final String type;
  const InventoryTab({super.key}); // <- Add this.type here

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SearchBarWidget(),
          Expanded(child: ProductGrid()),
        ],
      ),
    ); // Pass type when required
  }
}

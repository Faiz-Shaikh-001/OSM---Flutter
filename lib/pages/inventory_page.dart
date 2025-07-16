import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/grid_view.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add stock logic

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('FAB Pressed!')));
        },
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        tooltip: 'Add Stock',
        child: Icon(Icons.add),
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
          Center(
            child: Column(
              children: [
                SearchBarWidget(),
                Expanded(child: GridViewWidget()),
              ],
            ),
          ),
          Center(child: Column(children: [SearchBarWidget()])),
        ],
      ),
    );
  }
}

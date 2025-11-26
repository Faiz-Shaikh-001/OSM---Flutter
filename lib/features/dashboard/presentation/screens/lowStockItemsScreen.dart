import 'package:flutter/material.dart';
import 'package:osm/features/inventory/data/repositories/inventory_repository.dart';
import 'package:provider/provider.dart';

class LowStockItemsScreen extends StatelessWidget {
  const LowStockItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<InventoryRepository>();
    final lowStockItems = repo.lowStockItems; // We will add this shortly

    return Scaffold(
      appBar: AppBar(
        title: const Text("Low Stock Items"),
        elevation: 2,
      ),
      body: lowStockItems.isEmpty
          ? const Center(
              child: Text(
                "No items are below minimum stock level!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: lowStockItems.length,
              itemBuilder: (context, index) {
                final item = lowStockItems[index];

                final isFrame = item.frame.value != null;
                final productName = isFrame
                    ? item.frame.value!.name
                    : item.lens.value?.productName ?? "Unknown";

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      productName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "Quantity: ${item.quantityOnHand} | Min: ${item.minStockLevel}",
                    ),
                    trailing: const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

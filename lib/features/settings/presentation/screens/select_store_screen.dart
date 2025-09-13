import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Adjust paths as needed
import 'package:osm/core/services/isar_service.dart';
import '../../../orders/data/models/store_model.dart';
import 'manage_stores_screen.dart';

const String selectedStoreIdKey = 'selected_store_id';

class SelectStoreScreen extends StatefulWidget {
  const SelectStoreScreen({super.key});

  @override
  State<SelectStoreScreen> createState() => _SelectStoreScreenState();
}

class _SelectStoreScreenState extends State<SelectStoreScreen> {
  final IsarService isarService = IsarService();
  List<Store> _stores = [];
  int? _currentlySelectedId;

  @override
  void initState() {
    super.initState();
    _loadStoresAndSelection();
  }

  Future<void> _loadStoresAndSelection() async {
    final isar = await isarService.db;
    final prefs = await SharedPreferences.getInstance();
    final allStores = await isar.stores.where().findAll();
    
    setState(() {
      _stores = allStores;
      _currentlySelectedId = prefs.getInt(selectedStoreIdKey);
    });
  }

  Future<void> _selectStore(int storeId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(selectedStoreIdKey, storeId);
    // Pop the screen, returning 'true' to indicate a selection was made.
    if (mounted) {
      Navigator.of(context).pop(true);
    }
  }

  void _manageStores() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ManageStoresScreen()),
    );
    // After returning from managing stores, reload the list in case of changes
    _loadStoresAndSelection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Store or Branch'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Add or Edit Stores',
            onPressed: _manageStores,
          ),
        ],
      ),
      body: _stores.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No stores found.", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Your First Store'),
                    onPressed: _manageStores,
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: _stores.length,
              itemBuilder: (context, index) {
                final store = _stores[index];
                final isSelected = store.id == _currentlySelectedId;
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  color: isSelected ? Theme.of(context).primaryColorLight : null,
                  child: ListTile(
                    title: Text(store.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${store.address}, ${store.city}'),
                    trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : null,
                    onTap: () => _selectStore(store.id),
                  ),
                );
              },
            ),
    );
  }
}

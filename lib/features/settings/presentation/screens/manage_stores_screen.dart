import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
// Adjust the path to your IsarService file if it's different
import 'package:osm/core/services/isar_service.dart'; 
import '../../../orders/data/models/store_model.dart';
import 'add_edit_store_screen.dart';


class ManageStoresScreen extends StatefulWidget {
  const ManageStoresScreen({super.key});

  @override
  State<ManageStoresScreen> createState() => _ManageStoresScreenState();
}

class _ManageStoresScreenState extends State<ManageStoresScreen> {
  // Use the singleton instance of your service
  final IsarService isarService = IsarService();
  late Isar isar;
  List<Store> _stores = [];
  bool _isDbReady = false;

  @override
  void initState() {
    super.initState();
    _initializeDbAndListen();
  }
  
  // This function now handles getting the DB instance and setting up the listener
  Future<void> _initializeDbAndListen() async {
    isar = await isarService.db;
    setState(() {
      _isDbReady = true;
    });
    _listenForStoreChanges();
  }

  void _listenForStoreChanges() {
    isar.stores.watchLazy(fireImmediately: true).listen((_) {
      if (mounted) {
        _loadStores();
      }
    });
  }

  Future<void> _loadStores() async {
    final stores = await isar.stores.where().findAll();
    if (mounted) {
      setState(() {
        _stores = stores;
      });
    }
  }

  Future<void> _addOrUpdateStore(Store store) async {
    await isar.writeTxn(() async {
      await isar.stores.put(store);
    });
  }
  
  Future<void> _deleteStore(int storeId) async {
    await isar.writeTxn(() async {
      await isar.stores.delete(storeId);
    });
  }

  // --- Navigation ---

  void _navigateAndAddStore() async {
    final newStore = await Navigator.of(context).push<Store>(
      MaterialPageRoute(
        builder: (context) => const AddEditStoreScreen(),
      ),
    );

    if (newStore != null && mounted) {
      await _addOrUpdateStore(newStore);
    }
  }

  void _navigateAndEditStore(Store store) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddEditStoreScreen(storeToEdit: store),
      ),
    );

    if (result is Store && mounted) {
      await _addOrUpdateStore(result);
    } else if (result == true && mounted) {
      await _deleteStore(store.id);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Stores'),
      ),
      body: _isDbReady 
          ? _buildStoreList()
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndAddStore,
        tooltip: 'Add Store',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStoreList() {
    if (_stores.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            "You haven't added any stores yet.\nTap the '+' button to get started.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: _stores.length,
      itemBuilder: (context, index) {
        final store = _stores[index];
        // Combine address and city for the subtitle, handling cases where one might be empty.
        final addressParts = [store.address, store.city];
        final subtitleText = addressParts.where((part) => part.isNotEmpty).join(', ');

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: ListTile(
            title: Text(store.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(subtitleText),
            trailing: const Icon(Icons.edit, color: Colors.grey),
            onTap: () => _navigateAndEditStore(store),
          ),
        );
      },
    );
  }
}


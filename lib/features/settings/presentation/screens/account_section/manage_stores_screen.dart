import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/store/domain/entities/store_location.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';
import 'store_form_screen.dart';

class ManageStoresScreen extends StatelessWidget {
  const ManageStoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Stores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<StoreLocationBloc>(),
                    child: const StoreFormScreen(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<StoreLocationBloc, StoreLocationState>(
        builder: (context, state) {
          if (state is StoreLocationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is StoreLocationError) {
            return Center(child: Text(state.message));
          }

          if (state is StoreLocationLoaded) {
            return ListView.separated(
              itemCount: state.stores.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final store = state.stores[index];
                final isActive =
                    state.activeStore?.id?.value == store.id?.value;

                return _StoreTile(store: store, isActive: isActive);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _StoreTile extends StatelessWidget {
  final StoreLocation store;
  final bool isActive;

  const _StoreTile({required this.store, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(isActive ? Icons.storefront : Icons.store_outlined),
      ),
      title: Text(store.name),
      subtitle: Text('${store.city}, ${store.state}'),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          switch (value) {
            case 'active':
              context.read<StoreLocationBloc>().add(
                SetActiveStoreLocationEvent(store.id!),
              );
              break;

            case 'edit':
              // Step D – Edit Store screen
              break;

            case 'delete':
              _confirmDelete(context);
              break;
          }
        },
        itemBuilder: (_) => [
          if (!isActive)
            const PopupMenuItem(value: 'active', child: Text('Set as Active')),
          const PopupMenuItem(value: 'edit', child: Text('Edit')),
          const PopupMenuItem(
            value: 'delete',
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Store'),
        content: const Text('Are you sure you want to delete this store?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<StoreLocationBloc>().add(
                DeleteStoreLocationEvent(store.id!),
              );
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

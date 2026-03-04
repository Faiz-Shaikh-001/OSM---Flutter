import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';
import 'add_edit_store_screen.dart';

class ManageStoresScreen extends StatelessWidget {
  const ManageStoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Stores')),
      body: BlocBuilder<StoreLocationBloc, StoreLocationState>(
        builder: (context, state) {
          if (state is StoreLocationInitial ||
              state is StoreLocationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is StoreLocationError) {
            return Center(child: Text(state.message));
          }

          if (state is StoreLocationLoaded) {
            final stores = state.stores;
            final active = state.activeStore;

            if (stores.isEmpty) {
              return const Center(child: Text('No stores found'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: stores.length,
              itemBuilder: (context, index) {
                final store = stores[index];
                final isActive = active?.id == store.id;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: isActive
                        ? BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1.5,
                          )
                        : BorderSide.none,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    title: Text(
                      store.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${store.city}, ${store.state}'),
                    trailing: isActive
                        ? Icon(
                            Icons.check_circle,
                            color:
                                Theme.of(context).colorScheme.primary,
                          )
                        : const Icon(Icons.radio_button_unchecked),
                    onTap: () {
                      if (!isActive && store.id != null) {
                        context.read<StoreLocationBloc>().add(
                              SetActiveStoreLocationEvent(store.id!),
                            );
                      }
                    },
                    onLongPress: () {
                      // Next step: Edit store
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<StoreLocationBloc>(),
                            child: AddEditStoreScreen(store: store),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<StoreLocationBloc>(),
                child: const AddEditStoreScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
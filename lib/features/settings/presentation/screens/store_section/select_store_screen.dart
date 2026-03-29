import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';
// import 'package:osm/features/store/presentation/bloc/store_location_event.dart';
// import 'package:osm/features/store/presentation/bloc/store_location_state.dart';

class SelectStoreScreen extends StatelessWidget {
  const SelectStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Store'),
      ),
      body: BlocBuilder<StoreLocationBloc, StoreLocationState>(
        builder: (context, state) {
          if (state is StoreLocationLoading ||
              state is StoreLocationInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is StoreLocationError) {
            return Center(child: Text(state.message));
          }

          if (state is StoreLocationLoaded) {
            final stores = state.stores;
            final activeStore = state.activeStore;

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: stores.length,
              itemBuilder: (context, index) {
                final store = stores[index];
                final isActive = activeStore?.id == store.id;

                return _StoreCard(
                  name: store.name,
                  location: '${store.city}, ${store.state}',
                  isActive: isActive,
                  onTap: () {
                    if (!isActive && store.id != null) {
                      context.read<StoreLocationBloc>().add(
                            SetActiveStoreLocationEvent(store.id!),
                          );
                    }
                    Navigator.pop(context);
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _StoreCard extends StatelessWidget {
  final String name;
  final String location;
  final bool isActive;
  final VoidCallback onTap;

  const _StoreCard({
    required this.name,
    required this.location,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: isActive ? 3 : 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isActive
            ? BorderSide(color: theme.colorScheme.primary, width: 1.5)
            : BorderSide.none,
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(location),
        trailing: isActive
            ? Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
              )
            : const Icon(Icons.radio_button_unchecked),
        onTap: onTap,
      ),
    );
  }
}
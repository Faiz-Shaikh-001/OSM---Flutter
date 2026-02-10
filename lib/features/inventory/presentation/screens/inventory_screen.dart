import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame_type.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens_type.dart';
import 'package:osm/features/inventory/presentation/blocs/accessory/accessory_list/accessory_list_bloc.dart';
import 'package:osm/features/inventory/presentation/blocs/frames/frame_list/frame_list_bloc.dart';
import 'package:osm/features/inventory/presentation/blocs/lens/lens_list/lens_list_bloc.dart';
import 'package:osm/features/inventory/presentation/screens/item_screen.dart';
import 'add_stock/screen/add_stock_screen.dart';
import '../../../../core/widgets/search_bar.dart';
import '../utils/product_grid.dart';
import '../../../../core/utils/product_type.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
              Tab(icon: Icon(Icons.gpp_good_outlined), text: 'Frames'),
              Tab(icon: Icon(Icons.lens_blur_outlined), text: 'Lens'),
              Tab(icon: Icon(Icons.how_to_vote_outlined), text: 'Accessories'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            InventoryTab(productType: ProductType.frame),
            InventoryTab(productType: ProductType.lens),
            InventoryTab(productType: ProductType.accessory),
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProducts();
    });
  }

  void _loadProducts() {
    switch (widget.productType) {
      case ProductType.frame:
        context.read<FrameListBloc>().add(LoadFramesEvent());
        break;
      case ProductType.lens:
        context.read<LensListBloc>().add(LoadLensesEvent());
        break;
      case ProductType.accessory:
        context.read<AccessoryListBloc>().add(LoadAccessoriesEvent());
        break;
    }
  }

  void _onSearch(String query) {
    if (query.isEmpty) {
      _loadProducts();
      return;
    }

    switch (widget.productType) {
      case ProductType.frame:
        context.read<FrameListBloc>().add(SearchFramesByNameEvent(query));
        break;
      case ProductType.lens:
        context.read<LensListBloc>().add(SearchLensesByProductNameEvent(query));
        break;
      case ProductType.accessory:
        context.read<AccessoryListBloc>().add(SearchAccessoriesByNameEvent(query));
        break;
    }
  }

  void _showProductActions(Object product) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),

              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 16),

              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  _onEditProduct(product);
                },
              ),

              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _onDeleteProduct(product);
                },
              ),

              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _onEditProduct(Object product) {
    switch (widget.productType) {
      case ProductType.frame:
        final frame = product as Frame;
        _navigateToEdit(productType: ProductType.frame, productId: frame.id!);
        break;

      case ProductType.lens:
        final lens = product as Lens;
        _navigateToEdit(productType: ProductType.lens, productId: lens.id!);
        break;

      case ProductType.accessory:
        final accessory = product as Accessory;
        _navigateToEdit(
          productType: ProductType.accessory,
          productId: accessory.id!,
        );
        break;
    }
  }

  void _navigateToEdit({
    required ProductType productType,
    required Object productId,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddStockScreen(
          isEdit: true,
          productType: productType,
          productId: productId,
        ),
      ),
    ).then((_) {
      _loadProducts();
    });
  }

  void _onDeleteProduct(Object product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text(
          'Are you sure you want to delete this product? '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              _dispatchDelete(product);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _dispatchDelete(Object product) {
    switch (widget.productType) {
      case ProductType.frame:
        final frame = product as Frame;
        context.read<FrameListBloc>().add(DeleteFrameEvent(frame.id!));
        break;

      case ProductType.lens:
        final lens = product as Lens;
        context.read<LensListBloc>().add(DeleteLensEvent(lens.id!));
        break;

      case ProductType.accessory:
        final accessory = product as Accessory;
        context.read<AccessoryListBloc>().add(DeleteAccessoryEvent(accessory.id!));
        break;
    }

    _loadProducts();
  }

  void _openProductDetails(Object product) {
    switch (widget.productType) {
      case ProductType.frame:
        final frame = product as Frame;
        _navigateToItem(productType: ProductType.frame, productId: int.parse(frame.id!.value));
        break;

      case ProductType.lens:
        final lens = product as Lens;
        _navigateToItem(productType: ProductType.lens, productId: int.parse(lens.id!.value));
        break;

      case ProductType.accessory:
        final accessory = product as Accessory;
        _navigateToItem(
          productType: ProductType.accessory,
          productId: int.parse(accessory.id!.value),
        );
        break;
    }
  }

  void _navigateToItem({
    required ProductType productType,
    required Object productId,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ItemScreen(productType: productType, productId: productId as Id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        SearchBarWidget(
          onChanged: _onSearch,
          onClear: _loadProducts,
          onFilterTap: _openFilterSheet,
        ),
        Expanded(
          child: switch (widget.productType) {
            ProductType.frame => _buildFrames(),
            ProductType.lens => _buildLens(),
            ProductType.accessory => _buildAccessories(),
          },
        ),
      ],
    );
  }

  Widget _buildFrames() {
    return BlocBuilder<FrameListBloc, FrameListState>(
      builder: (context, state) {
        if (state is FrameListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FrameListError) {
          return Center(child: Text(state.message));
        }

        if (state is FrameListLoaded) {
          if (state.frames.isEmpty) {
            return const Center(child: Text('No frames found'));
          }

          return RefreshIndicator(
            onRefresh: () async => _loadProducts(),
            child: ProductGrid(
              products: state.frames,
              productType: ProductType.frame,
              onRefresh: _loadProducts,
              onTap: (frame) {
                _openProductDetails(frame);
              },
              onLongPress: (frame) {
                _showProductActions(frame);
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLens() {
    return BlocBuilder<LensListBloc, LensListState>(
      builder: (context, state) {
        if (state is LensListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LensListError) {
          return Center(child: Text(state.message));
        }

        if (state is LensListLoaded) {
          if (state.lenses.isEmpty) {
            return const Center(child: Text('No lens found'));
          }

          return RefreshIndicator(
            onRefresh: () async => _loadProducts(),
            child: ProductGrid(
              products: state.lenses,
              productType: ProductType.lens,
              onRefresh: _loadProducts,
              onTap: (lens) {
                _openProductDetails(lens);
              },
              onLongPress: (lens) {
                _showProductActions(lens);
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildAccessories() {
    return BlocBuilder<AccessoryListBloc, AccessoryListState>(
      builder: (context, state) {
        if (state is AccessoryListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AccessoryListError) {
          return Center(child: Text(state.message));
        }

        if (state is AccessoryListLoaded) {
          if (state.accessories.isEmpty) {
            return const Center(child: Text('No accessory found'));
          }

          return RefreshIndicator(
            onRefresh: () async => _loadProducts(),
            child: ProductGrid(
              products: state.accessories,
              productType: ProductType.accessory,
              onRefresh: _loadProducts,
              onTap: (accessory) {
                _openProductDetails(accessory);
              },
              onLongPress: (accessory) {
                _showProductActions(accessory);
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filters',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Company / Brand
              ListTile(
                leading: const Icon(Icons.business),
                title: const Text('Filter by Company / Brand'),
                onTap: () {
                  Navigator.pop(context);
                  _showTextFilter(
                    label: 'Company / Brand',
                    onSubmit: (value) {
                      switch (widget.productType) {
                        case ProductType.frame:
                          context.read<FrameListBloc>().add(
                            SearchFramesByCompanyEvent(value),
                          );
                          break;
                        case ProductType.lens:
                          context.read<LensListBloc>().add(
                            SearchLensesByCompanyEvent(value),
                          );
                          break;
                        case ProductType.accessory:
                          context.read<AccessoryListBloc>().add(
                            SearchAccessoriesByBrandEvent(value),
                          );
                          break;
                      }
                    },
                  );
                },
              ),

              // Type (Frames & Lens only)
              if (widget.productType != ProductType.accessory)
                ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text('Filter by Type'),
                  onTap: () {
                    Navigator.pop(context);
                    _showTypeFilter();
                  },
                ),

              const Divider(),

              ListTile(
                leading: const Icon(Icons.refresh),
                title: const Text('Clear Filters'),
                onTap: () {
                  Navigator.pop(context);
                  _loadProducts();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTextFilter({
    required String label,
    required ValueChanged<String> onSubmit,
  }) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(label),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: label),
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (controller.text.isNotEmpty) {
                onSubmit(controller.text);
              }
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _showTypeFilter() {
    if (widget.productType == ProductType.frame) {
      _showFrameTypeFilter();
    } else if (widget.productType == ProductType.lens) {
      _showLensTypeFilter();
    }
  }

  void _showFrameTypeFilter() {
    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        children: FrameType.values
            .map(
              (FrameType type) => ListTile(
                title: Text(type.name),
                onTap: () {
                  Navigator.pop(context);
                  context.read<FrameListBloc>().add(SearchFramesByTypeEvent(type));
                },
              ),
            )
            .toList(),
      ),
    );
  }

  void _showLensTypeFilter() {
    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        children: LensType.values
            .map(
              (LensType type) => ListTile(
                title: Text(type.name),
                onTap: () {
                  Navigator.pop(context);
                  context.read<LensListBloc>().add(SearchLensesByTypeEvent(type));
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

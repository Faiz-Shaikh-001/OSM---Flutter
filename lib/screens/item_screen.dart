import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:osm/data/models/frame_model.dart';
import 'package:osm/data/models/frame_enums.dart';
import 'package:osm/data/models/lens_model.dart';
import 'package:osm/data/models/lens_enums.dart';
import 'package:osm/utils/product_type.dart';
import 'package:osm/viewmodels/frame_viewmodel.dart';
import 'package:osm/viewmodels/lens_viewmodel.dart';
import 'package:osm/widgets/qr_generator.dart';
import 'package:provider/provider.dart';
import '../widgets/color_dropdown_widget.dart';
import '../widgets/size_dropdown_widget.dart';
import '../widgets/custom_button.dart';
import 'package:osm/screens/update_stock_screen.dart';

class ItemPage extends StatefulWidget {
  final dynamic product;
  final ProductType productType;
  final int heroIndex;

  const ItemPage({
    super.key,
    required this.heroIndex,
    required this.product,
    required this.productType,
  });

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  FrameVariant? _selectedFrameVariant;

  @override
  void initState() {
    super.initState();
    if (widget.productType == ProductType.frame &&
        widget.product is FrameModel) {
      final frame = widget.product as FrameModel;
      if (frame.variants.isNotEmpty) {
        _selectedFrameVariant = frame.variants.first;
      }
    }
  }

  // Helper methods now use _selectedFrameVariant for frame details
  String _getImageUrl(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      final frame = product as FrameModel;
      final variant = _selectedFrameVariant ?? frame.variants.first;
      return variant.imageUrls.isNotEmpty
          ? variant.imageUrls.first
          : 'https://placehold.co/600x400/cccccc/000000?text=No+Image';
    } else if (type == ProductType.lens) {
      final lens = product as LensModel;
      return lens.variants.isNotEmpty &&
              lens.variants.first.imageUrls != null &&
              lens.variants.first.imageUrls!.isNotEmpty
          ? lens.variants.first.imageUrls!.first
          : 'https://placehold.co/600x400/cccccc/000000?text=No+Image';
    }
    return 'https://placehold.co/600x400/cccccc/000000?text=No+Image';
  }

  String _getTitle(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      return (product as FrameModel).name;
    } else if (type == ProductType.lens) {
      return (product as LensModel).productName;
    }
    return 'Unknown Product';
  }

  String _getCompanyName(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      return (product as FrameModel).companyName;
    } else if (type == ProductType.lens) {
      return (product as LensModel).companyName;
    }
    return 'N/A';
  }

  String _getSku(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      final frame = product as FrameModel;
      return frame.variants.isNotEmpty
          ? frame.variants.first.productCode ?? 'N/A'
          : 'N/A';
    } else if (type == ProductType.lens) {
      final lens = product as LensModel;
      return lens.variants.isNotEmpty
          ? lens.variants.first.productCode ?? 'N/A'
          : 'N/A';
    }
    return 'N/A';
  }

  double _getSalesPrice(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      final frame = product as FrameModel;
      return frame.variants.isNotEmpty
          ? frame.variants.first.salesPrice ?? 0.0
          : 0.0;
    } else if (type == ProductType.lens) {
      final lens = product as LensModel;
      return lens.variants.isNotEmpty
          ? lens.variants.first.salesPrice ?? 0.0
          : 0.0;
    }
    return 0.0;
  }

  double _getPurchasePrice(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      final frame = product as FrameModel;
      return frame.variants.isNotEmpty
          ? frame.variants.first.purchasePrice ?? 0.0
          : 0.0;
    } else if (type == ProductType.lens) {
      final lens = product as LensModel;
      return lens.variants.isNotEmpty
          ? lens.variants.first.purchasePrice ?? 0.0
          : 0.0;
    }
    return 0.0;
  }

  int _getQuantity(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      final frame = product as FrameModel;
      return frame.variants.isNotEmpty ? frame.variants.first.quantity ?? 0 : 0;
    } else if (type == ProductType.lens) {
      final lens = product as LensModel;
      return lens.variants.isNotEmpty ? lens.variants.first.quantity ?? 0 : 0;
    }
    return 0;
  }

  String _getCategory(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      return (product as FrameModel).frameType.displayName;
    } else if (type == ProductType.lens) {
      return (product as LensModel).lensType.displayName;
    }
    return 'N/A';
  }

  String? _getCurrentColorName(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      return _selectedFrameVariant?.colorName;
    }
    return null;
  }

  int? _getCurrentSize(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      return _selectedFrameVariant?.size;
    }
    return null;
  }

  // Method to handle color change from dropdown
  void _onColorChanged(Color newColor) {
    // Now receives Color object
    if (widget.productType == ProductType.frame &&
        widget.product is FrameModel) {
      final frame = widget.product as FrameModel;
      final newVariant = frame.variants.firstWhere(
        (v) => v.color == newColor, // Compare by Color object
        orElse: () => frame.variants.first,
      );
      setState(() {
        _selectedFrameVariant = newVariant;
      });
    }
  }

  // Method to handle size change from dropdown
  void _onSizeChanged(int newSize) {
    if (widget.productType == ProductType.frame &&
        widget.product is FrameModel) {
      final frame = widget.product as FrameModel;
      final newVariant = frame.variants.firstWhere(
        (v) => v.size == newSize,
        orElse: () => frame.variants.first,
      );
      setState(() {
        _selectedFrameVariant = newVariant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final FrameVariant? currentFrameVariant =
        widget.productType == ProductType.frame && widget.product is FrameModel
        ? (widget.product as FrameModel).variants.isNotEmpty
              ? (widget.product as FrameModel).variants.first
              : null
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(_getTitle(widget.product, widget.productType)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroImage(widget.product, widget.productType),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: _buildProductDetails(
                  context,
                  widget.product,
                  widget.productType,
                  currentFrameVariant,
                ),
              ),

              //Update Stock Button Navigation
              CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdateStockScreen(),
                      settings: RouteSettings(
                        arguments: {
                          'product': widget.product,
                          'productType': widget.productType,
                          'name': _getTitle(widget.product, widget.productType),
                          'quantity': _getQuantity(
                            widget.product,
                            widget.productType,
                          ),
                          'color': _getCurrentColorName(
                            widget.product,
                            widget.productType,
                          ),
                          'size': _getCurrentSize(
                            widget.product,
                            widget.productType,
                          ),
                          'purchase_price': _getPurchasePrice(
                            widget.product,
                            widget.productType,
                          ),
                          'selling_price': _getSalesPrice(
                            widget.product,
                            widget.productType,
                          ),
                          'image': _getImageUrl(
                            widget.product,
                            widget.productType,
                          ),
                        },
                      ),
                    ),
                  );
                },
                label: 'Edit Stock',
                icon: Icons.edit_outlined,
              ),

              const SizedBox(height: 10),
              CustomButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QrGeneratorWidget(
                        product: widget.product,
                        productType: widget.productType,
                      ),
                    ),
                  );
                },
                label: 'Generate QR Code',
                icon: Icons.qr_code,
                background: Color(0xfff0f4f9),
                foreGround: Colors.black,
              ),
              const SizedBox(height: 25),
              CustomButton(
                onPressed: () async {
                  final confirmDelete = await _showDeleteConfirmationDialog(
                    context,
                  );
                  if (confirmDelete) {
                    try {
                      if (widget.productType == ProductType.frame) {
                        await context.read<FrameViewmodel>().deleteFrame(
                          widget.product.id,
                        );
                      } else {
                        await context.read<LensViewmodel>().deleteLens(
                          widget.product.id,
                        );
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${_getTitle(widget.product, widget.productType)} deleted successfully!',
                          ),
                        ),
                      );
                      Navigator.pop(context); // Go back after deletion
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to delete product: $e')),
                      );
                    }
                  }
                },
                label: 'Delete Product',
                icon: Icons.delete_forever_outlined,
                background: Color(0xfff0f4f9),
                foreGround: Colors.red,
              ),
              const SizedBox(height: 25),
              const DeleteWarningBanner(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage(dynamic product, ProductType productType) {
    return Hero(
      tag: 'itemImage_${product.id}_${widget.heroIndex}',
      child: CachedNetworkImage(
        imageUrl: _getImageUrl(product, productType),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 300,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const SizedBox(
          width: double.infinity,
          height: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.broken_image), Text('Error loading image')],
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails(
    BuildContext context,
    dynamic product,
    ProductType productType,
    FrameVariant? currentFrameVariant,
  ) {
    final titleStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    final labelStyle = TextStyle(fontSize: 20, color: Colors.grey);
    final priceStyle = TextStyle(
      fontSize: 25,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    );
    final stockStyle = TextStyle(fontSize: 20, color: Colors.blueGrey);
    final captionStyle = TextStyle(fontSize: 15, color: Colors.blueGrey);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${_getCompanyName(product, productType)} - ${_getTitle(product, productType)}",
          style: titleStyle,
        ),
        Text('SKU: ${_getSku(product, productType)}', style: labelStyle),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '₹${_getSalesPrice(product, productType).toStringAsFixed(2)}',
              style: priceStyle,
            ),
            Text(
              'In Stock: ${_getQuantity(product, productType)}',
              style: stockStyle,
            ),
          ],
        ),
        const SizedBox(height: 25),
        if (productType == ProductType.frame &&
            currentFrameVariant != null) ...[
          // Assuming ColorDropDownWidget and SizeDropdownWidget are generic enough
          // or you adapt them to take FrameVariant data.
          // For now, they are placeholders as they don't seem to take dynamic data.
          // You'd need to pass selected color/size and available options.
          ColorDropDownWidget(
            availableColorsWithNames: (product as FrameModel).variants
                .where((v) => v.colorName != null && v.color != null)
                .map((v) => MapEntry(v.colorName!, v.color!))
                .toList(),
            selectedColorName: _getCurrentColorName(product, productType),
            onColorChanged: _onColorChanged,
          ),
          SizeDropdownWidget(
            selectedSize: currentFrameVariant.size,
            availableSizes: (product).variants
                .map((v) => v.size)
                .whereType<int>()
                .toList(),
            onSizeChanged: _onSizeChanged,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Category', style: captionStyle),
              Text(
                _getCategory(product, productType),
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ],
    );
  }

  // Helper method to build specific details for Frame or Lens
  Widget _buildSpecificDetails(
    BuildContext context,
    dynamic product,
    ProductType type,
  ) {
    if (type == ProductType.frame) {
      final frame = product as FrameModel;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Frame Type: ${frame.frameType.displayName}'),
          if (frame.variants.isNotEmpty) ...[
            Text('Color: ${frame.variants.first.colorName ?? 'N/A'}'),
            Text('Size: ${frame.variants.first.size ?? 'N/A'}'),
          ],
          // Add more frame-specific details here
        ],
      );
    } else if (type == ProductType.lens) {
      final lens = product as LensModel;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lens Type: ${lens.lensType.displayName}'),
          if (lens.variants.isNotEmpty) ...[
            Text(
              'Material: ${lens.variants.first.materialType?.displayName ?? 'N/A'}',
            ),
            Text('Spherical: ${lens.variants.first.spherical ?? 'N/A'}'),
            Text('Cylindrical: ${lens.variants.first.cylindrical ?? 'N/A'}'),
            Text('Axis: ${lens.variants.first.axis ?? 'N/A'}'),
            Text('Add Power: ${lens.variants.first.add ?? 'N/A'}'),
            Text('Base Curve: ${lens.variants.first.baseCurve ?? 'N/A'}'),
            Text('Side: ${lens.variants.first.side?.displayName ?? 'N/A'}'),
          ],
          // Add more lens-specific details here
        ],
      );
    }
    return const Text('No specific details available.');
  }

  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Confirm Deletion'),
              content: const Text(
                'Are you sure you want to permanently delete this product? This action cannot be undone.',
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(
                      dialogContext,
                    ).pop(false); // Dismiss dialog and return false
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text('Delete'),
                  onPressed: () {
                    Navigator.of(
                      dialogContext,
                    ).pop(true); // Dismiss dialog and return true
                  },
                ),
              ],
            );
          },
        ) ??
        false; // Return false if dialog is dismissed by tapping outside
  }
}

class DeleteWarningBanner extends StatelessWidget {
  const DeleteWarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: .2, color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width * .9,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.warning, color: Colors.red),
            const SizedBox(width: 10),
            Expanded(
              child: const Text(
                'Deleting this product will permanently remove it from the inventory. This action cannot be undone.',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

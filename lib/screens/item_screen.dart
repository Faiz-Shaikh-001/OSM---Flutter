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
  late dynamic _currentProduct;
  FrameVariant? _selectedFrameVariant;
  LensVariant? _selectedLensVariant;

  @override
  void initState() {
    super.initState();
    _currentProduct = widget.product;
    _initializeVariants();
  }

  void _initializeVariants() {
    if (widget.productType == ProductType.frame &&
        _currentProduct is FrameModel) {
      final frame = _currentProduct as FrameModel;
      if (frame.variants.isNotEmpty) {
        _selectedFrameVariant = frame.variants.firstWhere(
          (v) => v.productCode == _selectedFrameVariant?.productCode,
          orElse: () => frame.variants.first,
        );
      }
    } else if (widget.productType == ProductType.lens &&
        _currentProduct is LensModel) {
      final lens = _currentProduct as LensModel;
      if (lens.variants.isNotEmpty) {
        _selectedLensVariant = lens.variants.firstWhere(
          (v) => v.productCode == _selectedLensVariant?.productCode,
          orElse: () => lens.variants.first,
        );
      }
    }
  }

  void _refreshProductData() {
    if (!mounted) return;

    if (widget.productType == ProductType.frame) {
      final viewModel = context.read<FrameViewmodel>();
      final updatedProduct = viewModel.frames.firstWhere(
        (frame) => frame.id == widget.product.id,
        orElse: () => _currentProduct,
      );

      setState(() {
        _currentProduct = updatedProduct;
        _initializeVariants();
      });
    } else if (widget.productType == ProductType.lens) {
      final viewModel = context.read<LensViewmodel>();
      final updatedProduct = viewModel.lens.firstWhere(
        (lens) => lens.id == widget.product.id,
        orElse: () => _currentProduct,
      );

      setState(() {
        _currentProduct = updatedProduct;
        _initializeVariants();
      });
    }
  }

  String _getImageUrl() {
    if (widget.productType == ProductType.frame) {
      return _selectedFrameVariant?.imageUrls.isNotEmpty ?? false
          ? _selectedFrameVariant!.imageUrls.first
          : 'https://placehold.co/600x400/cccccc/000000?text=No+Image';
    } else if (widget.productType == ProductType.lens) {
      return _selectedLensVariant?.imageUrls?.isNotEmpty == true
          ? _selectedLensVariant!.imageUrls!.first
          : 'https://placehold.co/600x400/cccccc/000000?text=No+Image';
    }
    return 'https://placehold.co/600x400/cccccc/000000?text=No+Image';
  }

  String _getTitle() {
    if (widget.productType == ProductType.frame) {
      return (_currentProduct as FrameModel).name;
    } else if (widget.productType == ProductType.lens) {
      return (_currentProduct as LensModel).productName;
    }
    return 'Unknown Product';
  }

  String _getCompanyName() {
    if (widget.productType == ProductType.frame) {
      return (_currentProduct as FrameModel).companyName;
    } else if (widget.productType == ProductType.lens) {
      return (_currentProduct as LensModel).companyName;
    }
    return 'N/A';
  }

  String _getSku() {
    if (widget.productType == ProductType.frame) {
      return _selectedFrameVariant?.productCode ?? 'N/A';
    } else if (widget.productType == ProductType.lens) {
      return _selectedLensVariant?.productCode ?? 'N/A';
    }
    return 'N/A';
  }

  double _getSalesPrice() {
    if (widget.productType == ProductType.frame) {
      return _selectedFrameVariant?.salesPrice ?? 0.0;
    } else if (widget.productType == ProductType.lens) {
      return _selectedLensVariant?.salesPrice ?? 0.0;
    }
    return 0.0;
  }

  int _getQuantity() {
    if (widget.productType == ProductType.frame) {
      return _selectedFrameVariant?.quantity ?? 0;
    } else if (widget.productType == ProductType.lens) {
      return _selectedLensVariant?.quantity ?? 0;
    }
    return 0;
  }

  String _getCategory() {
    if (widget.productType == ProductType.frame) {
      return (_currentProduct as FrameModel).frameType.displayName;
    } else if (widget.productType == ProductType.lens) {
      return (_currentProduct as LensModel).lensType.displayName;
    }
    return 'N/A';
  }

  void _onColorChanged(Color newColor) {
    if (widget.productType == ProductType.frame &&
        _currentProduct is FrameModel) {
      final frame = _currentProduct as FrameModel;
      final newVariant = frame.variants.firstWhere(
        (v) => v.color == newColor && v.size == _selectedFrameVariant?.size,
        orElse: () => _selectedFrameVariant!,
      );
      setState(() {
        _selectedFrameVariant = newVariant;
      });
    }
  }

  void _onSizeChanged(int newSize) {
    if (widget.productType == ProductType.frame &&
        _currentProduct is FrameModel) {
      final frame = _currentProduct as FrameModel;
      final newVariant = frame.variants.firstWhere(
        (v) => v.size == newSize && v.color == _selectedFrameVariant?.color,
        orElse: () => _selectedFrameVariant!,
      );
      setState(() {
        _selectedFrameVariant = newVariant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(_getTitle())),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroImage(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: _buildProductDetails(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: _buildSpecificDetails(context),
              ),
              const SizedBox(height: 25),
              _buildActionButtons(context),
              const SizedBox(height: 25),
              const DeleteWarningBanner(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage() {
    return Hero(
      tag: 'itemImage_${widget.product.id}_${widget.heroIndex}',
      child: CachedNetworkImage(
        imageUrl: _getImageUrl(),
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
            children: [Icon(Icons.broken_image), Text(' Error loading image')],
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    final labelStyle = TextStyle(fontSize: 20, color: Colors.grey);
    final priceStyle = TextStyle(
      fontSize: 25,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    );
    final stockStyle = TextStyle(fontSize: 20, color: Colors.blueGrey);

    final frame =
        widget.productType == ProductType.frame ? _currentProduct as FrameModel : null;
    final availableSizes =
        frame?.variants.map((v) => v.size).whereType<int>().toSet().toList() ?? [];
    final availableColors = frame?.variants
            .where((v) => v.colorName != null && v.color != null)
            .map((v) => MapEntry(v.colorName!, v.color!))
            .toSet()
            .toList() ??
        [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${_getCompanyName()} - ${_getTitle()}",
          style: titleStyle,
        ),
        Text('SKU: ${_getSku()}', style: labelStyle),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '₹${_getSalesPrice().toStringAsFixed(2)}',
              style: priceStyle,
            ),
            Text(
              'In Stock: ${_getQuantity()}',
              style: stockStyle,
            ),
          ],
        ),
        const SizedBox(height: 25),
        if (widget.productType == ProductType.frame &&
            _selectedFrameVariant != null) ...[
          // --- THIS IS THE ONLY SECTION THAT HAS CHANGED ---
          Row(
            children: [
              Expanded(
                child: ColorDropDownWidget(
                  availableColorsWithNames: availableColors,
                  selectedColorName: _selectedFrameVariant!.colorName,
                  onColorChanged: _onColorChanged,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: _selectedFrameVariant!.color ?? Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade400),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8), // Spacing between dropdowns
          SizeDropdownWidget(
            selectedSize: _selectedFrameVariant!.size,
            availableSizes: availableSizes,
            onSizeChanged: _onSizeChanged,
          ),
          const SizedBox(height: 15),
        ],
      ],
    );
  }

  Widget _buildSpecificDetails(BuildContext context) {
    final captionStyle = TextStyle(fontSize: 15, color: Colors.blueGrey);
    final valueStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);

    Widget detailRow(String label, String value) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: captionStyle),
            Text(value, style: valueStyle),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          detailRow('Category', _getCategory()),
          if (widget.productType == ProductType.lens &&
              _selectedLensVariant != null) ...[
            detailRow('Material',
                _selectedLensVariant!.materialType?.displayName ?? 'N/A'),
            detailRow(
                'Side', _selectedLensVariant!.side?.displayName ?? 'N/A'),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          onPressed: () async {
            final didUpdate = await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateStockScreen(
                  product: _currentProduct,
                  productType: widget.productType,
                  selectedVariant: widget.productType == ProductType.frame
                      ? _selectedFrameVariant
                      : _selectedLensVariant,
                ),
              ),
            );

            if (didUpdate == true) {
              _refreshProductData();
            }
          },
          label: 'Edit Stock',
          icon: Icons.edit_outlined,
        ),
        const SizedBox(height: 10),
        CustomButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QrGeneratorWidget(
                  product: _currentProduct,
                  productType: widget.productType,
                ),
              ),
            );
          },
          label: 'Generate QR Code',
          icon: Icons.qr_code,
          background: const Color(0xfff0f4f9),
          foreGround: Colors.black,
        ),
        const SizedBox(height: 25),
        CustomButton(
          onPressed: () async {
            final frameViewModel = context.read<FrameViewmodel>();
            final lensViewModel = context.read<LensViewmodel>();
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            final navigator = Navigator.of(context);
            
            final confirmDelete = await _showDeleteConfirmationDialog(context);

            if (confirmDelete) {
              try {
                if (widget.productType == ProductType.frame) {
                  await frameViewModel.deleteFrame(widget.product.id);
                } else {
                  await lensViewModel.deleteLens(widget.product.id);
                }
                
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('${_getTitle()} deleted successfully!'),
                  ),
                );
                navigator.pop();
              } catch (e) {
                scaffoldMessenger.showSnackBar(
                  SnackBar(content: Text('Failed to delete product: $e')),
                );
              }
            }
          },
          label: 'Delete Product',
          icon: Icons.delete_forever_outlined,
          background: const Color(0xfff0f4f9),
          foreGround: Colors.red,
        ),
      ],
    );
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
                    Navigator.of(dialogContext).pop(false);
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text('Delete'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
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

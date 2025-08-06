import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';
import 'package:osm/data/models/frame_model.dart';
import 'package:osm/data/models/lens_model.dart';
import 'package:osm/utils/product_type.dart';
import 'package:osm/viewmodels/frame_viewmodel.dart';
import 'package:osm/viewmodels/lens_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class UpdateStockScreen extends StatefulWidget {
  final dynamic product;
  final ProductType productType;
  final dynamic selectedVariant;

  const UpdateStockScreen({
    super.key,
    required this.product,
    required this.productType,
    this.selectedVariant,
  });

  @override
  State<UpdateStockScreen> createState() => _UpdateStockScreenState();
}

class _UpdateStockScreenState extends State<UpdateStockScreen> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController purchasePriceController;
  late TextEditingController sellingPriceController;
  late TextEditingController sizeController;
  late TextEditingController hexColorController;

  late Color _selectedColor;

  String? existingImageUrl;
  File? newImageFile;
  bool _isUpdating = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeFormFields();
    hexColorController.addListener(_onHexFieldChanged);
  }

  void _initializeFormFields() {
    String name = '';
    String quantity = '0';
    String purchasePrice = '0.0';
    String sellingPrice = '0.0';
    String size = '';
    _selectedColor = Colors.grey;

    if (widget.productType == ProductType.frame) {
      final frame = widget.product as FrameModel;
      final variant = widget.selectedVariant as FrameVariant?;
      name = frame.name;
      if (variant != null) {
        quantity = variant.quantity?.toString() ?? '0';
        purchasePrice = variant.purchasePrice?.toString() ?? '0.0';
        sellingPrice = variant.salesPrice?.toString() ?? '0.0';
        size = variant.size?.toString() ?? '';
        _selectedColor = variant.color ?? Colors.grey;
        if (variant.imageUrls.isNotEmpty) {
          existingImageUrl = variant.imageUrls.first;
        }
      }
    } else if (widget.productType == ProductType.lens) {
      final lens = widget.product as LensModel;
      final variant = widget.selectedVariant as LensVariant?;
      name = lens.productName;
      if (variant != null) {
        quantity = variant.quantity?.toString() ?? '0';
        purchasePrice = variant.purchasePrice?.toString() ?? '0.0';
        sellingPrice = variant.salesPrice?.toString() ?? '0.0';
        if (variant.imageUrls?.isNotEmpty == true) {
          existingImageUrl = variant.imageUrls!.first;
        }
      }
    }

    nameController = TextEditingController(text: name);
    quantityController = TextEditingController(text: quantity);
    purchasePriceController = TextEditingController(text: purchasePrice);
    sellingPriceController = TextEditingController(text: sellingPrice);
    hexColorController = TextEditingController(text: _colorToHex(_selectedColor));
    sizeController = TextEditingController(text: size);
  }

  @override
  void dispose() {
    hexColorController.removeListener(_onHexFieldChanged);
    nameController.dispose();
    quantityController.dispose();
    purchasePriceController.dispose();
    sellingPriceController.dispose();
    hexColorController.dispose();
    sizeController.dispose();
    super.dispose();
  }

  String _colorToHex(Color color) {
    return color.value.toRadixString(16).substring(2).toUpperCase();
  }

  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    try {
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return _selectedColor;
    }
  }

  void _onHexFieldChanged() {
    final text = hexColorController.text;
    if (text.length == 6) {
      setState(() {
        _selectedColor = _hexToColor(text);
      });
    }
  }

  Future<void> _pickImage() async {
    if (_isUpdating) return;
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        newImageFile = File(pickedFile.path);
      });
    }
  }

  void _pickColor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _selectedColor,
            onColorChanged: (color) {
              setState(() {
                _selectedColor = color;
                hexColorController.text = _colorToHex(color);
              });
            },
            labelTypes: const [ColorLabelType.hex],
            pickerAreaHeightPercent: 0.8,
            enableAlpha: false,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Done'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _updateStock() async {
    if (_isUpdating) return;

    setState(() {
      _isUpdating = true;
    });

    try {
      if (widget.productType == ProductType.frame) {
        final frameViewModel = context.read<FrameViewmodel>();
        final originalFrame = widget.product as FrameModel;
        final originalVariant = widget.selectedVariant as FrameVariant;

        final updatedVariant = originalVariant.copyWith(
          quantity: int.tryParse(quantityController.text.trim()) ?? originalVariant.quantity,
          purchasePrice: double.tryParse(purchasePriceController.text.trim()) ?? originalVariant.purchasePrice,
          salesPrice: double.tryParse(sellingPriceController.text.trim()) ?? originalVariant.salesPrice,
          colorName: hexColorController.text.trim().toUpperCase(),
          color: _selectedColor,
          size: int.tryParse(sizeController.text.trim()) ?? originalVariant.size,
          localImagesPaths: newImageFile != null ? [newImageFile!.path] : originalVariant.localImagesPaths,
        );

        final variantIndex = originalFrame.variants.indexWhere(
          (v) => v.productCode == originalVariant.productCode
        );

        final newVariantsList = List<FrameVariant>.from(originalFrame.variants);
        if (variantIndex != -1) {
          newVariantsList[variantIndex] = updatedVariant;
        }

        final updatedFrame = originalFrame.copyWith(
          name: nameController.text.trim(),
          variants: newVariantsList,
        );

        await frameViewModel.updateFrame(updatedFrame);

      } else if (widget.productType == ProductType.lens) {
        // --- THIS IS THE IMPLEMENTED LENS UPDATE LOGIC ---
        final lensViewModel = context.read<LensViewmodel>();
        final originalLens = widget.product as LensModel;
        final originalVariant = widget.selectedVariant as LensVariant;

        final updatedVariant = originalVariant.copyWith(
          quantity: int.tryParse(quantityController.text.trim()) ?? originalVariant.quantity,
          purchasePrice: double.tryParse(purchasePriceController.text.trim()) ?? originalVariant.purchasePrice,
          salesPrice: double.tryParse(sellingPriceController.text.trim()) ?? originalVariant.salesPrice,
          localImagesPaths: newImageFile != null ? [newImageFile!.path] : originalVariant.localImagesPaths,
        );

        final variantIndex = originalLens.variants.indexWhere(
          (v) => v.productCode == originalVariant.productCode
        );
        
        final newVariantsList = List<LensVariant>.from(originalLens.variants);
        if(variantIndex != -1) {
          newVariantsList[variantIndex] = updatedVariant;
        }

        final updatedLens = originalLens.copyWith(
          productName: nameController.text.trim(),
          variants: newVariantsList,
        );

        await lensViewModel.update(updatedLens);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Stock updated successfully!')),
      );

      Navigator.of(context).pop(true);

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update stock: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Stock'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Edit Image',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: newImageFile != null
                          ? Image.file(newImageFile!, fit: BoxFit.cover)
                          : existingImageUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: existingImageUrl!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )
                              : const Center(
                                  child: Icon(Icons.add_a_photo,
                                      size: 50, color: Colors.grey)),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black54,
                      ),
                      child:
                          const Icon(Icons.edit, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildTextFormField(
              controller: nameController,
              labelText: 'Product Name',
            ),
            _buildTextFormField(
              controller: quantityController,
              labelText: 'Quantity',
              keyboardType: TextInputType.number,
            ),
            if (widget.productType == ProductType.frame) ...[
              _buildTextFormField(
                controller: sizeController,
                labelText: 'Size',
                keyboardType: TextInputType.number,
              ),
            ],
            _buildTextFormField(
              controller: purchasePriceController,
              labelText: 'Purchase Price',
              keyboardType: TextInputType.number,
            ),
            _buildTextFormField(
              controller: sellingPriceController,
              labelText: 'Selling Price',
              keyboardType: TextInputType.number,
            ),

            if (widget.productType == ProductType.frame) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: hexColorController,
                      maxLength: 6,
                      decoration: InputDecoration(
                        labelText: 'Hex Color Code',
                        prefixText: '#',
                        counterText: "",
                        suffixIcon: const Icon(Icons.edit, size: 20, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      enabled: !_isUpdating,
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: _pickColor,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: _selectedColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _isUpdating ? null : _updateStock,
              child: _isUpdating
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : const Text('Update Stock'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: const Icon(Icons.edit, size: 20, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        keyboardType: keyboardType,
        enabled: !_isUpdating,
      ),
    );
  }
}

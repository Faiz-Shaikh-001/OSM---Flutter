import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:osm/core/services/save_image_to_app_directory.dart';
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/core/widgets/image_selector.dart';
import 'package:osm/features/inventory/presentation/dto/frame_variant_input.dart';

class AddFrameVariantSheet extends StatefulWidget {
  const AddFrameVariantSheet({super.key});

  @override
  State<AddFrameVariantSheet> createState() => _AddFrameVariantSheetState();
}

class _AddFrameVariantSheetState extends State<AddFrameVariantSheet> {
  final _formKey = GlobalKey<FormState>();

  final _productCodeCtrl = TextEditingController();
  final _hexCtrl = TextEditingController();
  final _sizeCtrl = TextEditingController();
  final _quantityCtrl = TextEditingController();
  final _purchasePriceCtrl = TextEditingController();
  final _salesPriceCtrl = TextEditingController();

  int? _colorValue;
  String? _colorName;
  bool _isResolvingColor = false;

  final List<File> _selectedImages = [];
  bool _isSaving = false;

  @override
  void dispose() {
    _hexCtrl.dispose();
    _sizeCtrl.dispose();
    _quantityCtrl.dispose();
    _purchasePriceCtrl.dispose();
    _salesPriceCtrl.dispose();
    _productCodeCtrl.dispose();
    super.dispose();
  }

  bool _isValidHex(String hex) {
    return RegExp(r'^[0-9A-Fa-f]{6}$').hasMatch(hex);
  }

  Future<void> _resolveColor(Color color) async {
    setState(() {
      _isResolvingColor = true;
      _colorValue = color.toARGB32();
    });
    final name = ColorTools.nameThatColor(color);
    setState(() {
      _colorName = name;
      _hexCtrl.text =
          '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
      _isResolvingColor = false;
    });
  }

  void _onHexChanged(String value) {
    final hex = value.replaceAll("#", "");
    if (_isValidHex(hex)) {
      final color = Color(int.parse('FF$hex', radix: 16));
      _resolveColor(color);
    }
  }

  Future<void> _pickColor() async {
    final color = await showDialog<Color>(
      context: context,
      builder: (_) {
        Color pickerColor = Colors.blue;
        return AlertDialog(
          title: const Text("Pick Color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              color: pickerColor,
              onColorChanged: (color) => pickerColor = color,
              pickersEnabled: <ColorPickerType, bool>{
                ColorPickerType.wheel: true,
                ColorPickerType.primary: true,
                ColorPickerType.accent: true,
              },
              enableShadesSelection: true,
              showColorName: true,
              showColorCode: true,
              showMaterialName: true,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, pickerColor);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (color != null) {
      await _resolveColor(color);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_colorValue == null || _colorName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select or enter a color')),
      );
      return;
    }

    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Add at least one image')));
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final List<String> savedImagePaths = [];

    for (final file in _selectedImages) {
      final path = await saveImageToAppDirectory(file);
      savedImagePaths.add(path);
    }

    final variant = FrameVariantInput(
      productCode: _productCodeCtrl.text.trim(),
      colorName: _colorName!,
      colorValue: _colorValue,
      size: int.parse(_sizeCtrl.text),
      quantity: int.parse(_quantityCtrl.text),
      purchasePrice: Money(double.parse(_purchasePriceCtrl.text)),
      salesPrice: Money(double.parse(_salesPriceCtrl.text)),
      imageUrls: savedImagePaths,
    );

    setState(() {
      _isSaving = false;
    });

    Navigator.pop(context, variant);
  }

  Widget _numberField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      validator: (v) =>
          v == null || int.tryParse(v) == null ? 'Invalid $label' : null,
    );
  }

  Widget _priceField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label),
      validator: (v) =>
          v == null || double.tryParse(v) == null ? 'Invalid $label' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Frame Variant',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              ImageSelectorWidget(
                selectedImages: _selectedImages,
                onImagesChanged: (imgs) => setState(() {
                  _selectedImages
                    ..clear()
                    ..addAll(imgs);
                }),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _hexCtrl,
                      textCapitalization: TextCapitalization.characters,
                      decoration: const InputDecoration(
                        labelText: 'Hex Color (#RRGGBB)',
                      ),
                      onChanged: _onHexChanged,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Hex color required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: _pickColor,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: _colorValue != null
                          ? Color(_colorValue!)
                          : Colors.grey,
                      child: const Icon(Icons.color_lens, color: Colors.white),
                    ),
                  ),
                ],
              ),

              if (_isResolvingColor)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: LinearProgressIndicator(),
                )
              else if (_colorName != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Color name: $_colorName',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),

              const SizedBox(height: 16),
              TextFormField(
                controller: _productCodeCtrl,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(labelText: 'Product Code'),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Product code required';
                  }

                  return null;
                },
              ),
              _numberField(_sizeCtrl, 'Size'),
              _numberField(_quantityCtrl, 'Quantity'),

              const SizedBox(height: 12),
              _priceField(_purchasePriceCtrl, 'Purchase Price'),
              _priceField(_salesPriceCtrl, 'Sales Price'),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: _isSaving
                      ? const CircularProgressIndicator()
                      : const Text('Add Variant'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

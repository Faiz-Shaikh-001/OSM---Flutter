import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm/data/models/frame_enums.dart';
import 'package:osm/services/color_api_service.dart';
import 'package:osm/widgets/build_text_field_widget.dart';
import 'package:osm/widgets/image_selector_widget.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../data/models/frame_model.dart';
import '../../widgets/custom_button.dart';

class FrameFormWidget extends StatefulWidget {
  final Function(FrameModel, List<FrameVariant>) onSubmit;

  const FrameFormWidget({super.key, required this.onSubmit});

  @override
  State<FrameFormWidget> createState() => _FrameFormWidgetState();
}

class VariantFormData {
  Color color;
  int size;
  int quantity;
  double purchasePrice;
  double salesPrice;

  VariantFormData({
    required this.color,
    required this.size,
    required this.quantity,
    required this.purchasePrice,
    required this.salesPrice,
  });
}

class _FrameFormWidgetState extends State<FrameFormWidget> {
  final _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();
  FrameType? _frameType;
  final List<File> _selectedImages = [];

  final _companyController = TextEditingController();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();

  final List<VariantFormData> _variantForms = [];

  @override
  void dispose() {
    _companyController.dispose();
    _nameController.dispose();
    _codeController.dispose();
    // Dispose controllers for VariantFormData if you make them TextEditingControllers
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _addVariant() {
    setState(() {
      _variantForms.add(
        VariantFormData(
          color: Colors.black,
          size: 0,
          quantity: 0,
          purchasePrice: 0,
          salesPrice: 0,
        ),
      );
    });
  }

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate() || _frameType == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please fll all required fields and select a frame type.',
            ),
          ),
        );
      }
      return;
    }

    if (_variantForms.isEmpty || _selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please add at least one variant and upload images."),
        ),
      );
      return;
    }

    if (_selectedImages.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please upload at least one image.")),
        );
      }
      return;
    }

    final String companyName = _companyController.text.trim();
    final String modelName = _nameController.text.trim();
    final String modelCode = _codeController.text.trim();

    final colorApiService = ColorApiService();

    final List<FrameVariant> variantsToSave = [];
    final List<String> imageUrlsToSave = _selectedImages
        .map((file) => file.path)
        .toList();

    for (final data in _variantForms) {
      final colorName = await colorApiService.getColorName(color: data.color);

      final String computedProductCode = FrameVariant.generateProductCode(
        _frameType!,
        companyName,
        modelName,
        modelCode,
        colorName,
        data.size,
      );

      final FrameVariant variant = FrameVariant(
        code: modelCode,
        color: data.color,
        colorName: colorName,
        productCode: computedProductCode,
        size: data.size,
        quantity: data.quantity,
        purchasePrice: data.purchasePrice,
        salesPrice: data.salesPrice,
        imageUrls: imageUrlsToSave,
        localImagesPaths: imageUrlsToSave,
      );

      variantsToSave.add(variant);
    }

    final frameModel = FrameModel(
      date: _selectedDate,
      companyName: companyName,
      frameType: _frameType!,
      name: modelName,
      variants: variantsToSave,
    );

    widget.onSubmit(frameModel, variantsToSave);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Frame stock saved succesfully!")),
      );

      // Navigator.pop(context);
    }
  }

  Widget _buildVariantRow(int index) {
    final data = _variantForms[index];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Color:"),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    final color = await showDialog<Color>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Pick a color"),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: data.color,
                            onColorChanged: (c) => data.color = c,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop(data.color),
                            child: const Text("Done"),
                          ),
                        ],
                      ),
                    );
                    if (color != null) {
                      setState(() => data.color = color);
                    }
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: data.color,
                      border: Border.all(),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () =>
                      setState(() => _variantForms.removeAt(index)),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            TextFormField(
              initialValue: data.size.toString(),
              decoration: const InputDecoration(labelText: "Size"),
              keyboardType: TextInputType.number,
              onChanged: (val) => data.size = int.tryParse(val) ?? 0,
            ),
            TextFormField(
              initialValue: data.quantity.toString(),
              decoration: const InputDecoration(labelText: "Quantity"),
              keyboardType: TextInputType.number,
              onChanged: (val) => data.quantity = int.tryParse(val) ?? 0,
            ),
            TextFormField(
              initialValue: data.purchasePrice.toString(),
              decoration: const InputDecoration(labelText: "Purchase Price"),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (val) =>
                  data.purchasePrice = double.tryParse(val) ?? 0,
            ),
            TextFormField(
              initialValue: data.salesPrice.toString(),
              decoration: const InputDecoration(labelText: "Sales Price"),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (val) => data.salesPrice = double.tryParse(val) ?? 0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ImageSelectorWidget(
              selectedImages: _selectedImages,
              onImagesChanged: (imgs) => setState(
                () => _selectedImages
                  ..clear()
                  ..addAll(imgs),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: _pickDate,
              title: Row(
                children: [Icon(Icons.calendar_month_outlined), Text('Date')],
              ),
              trailing: Text(
                DateFormat.yMMMd().format(_selectedDate),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            DropdownButtonFormField<FrameType>(
              decoration: const InputDecoration(labelText: 'Frame Type'),
              value: _frameType,
              items: FrameType.values.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.name));
              }).toList(),
              onChanged: (type) => setState(() => _frameType = type),
              validator: (value) => value == null ? 'Select frame type' : null,
            ),

            BuildTextFieldWidget(
              label: "Company Name",
              controller: _companyController,
            ),
            BuildTextFieldWidget(
              label: "Model Name",
              controller: _nameController,
            ),
            BuildTextFieldWidget(
              label: "Model Code",
              controller: _codeController,
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Variants",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: _addVariant,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Variant"),
                ),
              ],
            ),
            ..._variantForms.asMap().entries.map(
              (entry) => _buildVariantRow(entry.key),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: _handleSubmit,
              label: 'Save Stock',
              icon: Icons.check,
            ),
          ],
        ),
      ),
    );
  }
}

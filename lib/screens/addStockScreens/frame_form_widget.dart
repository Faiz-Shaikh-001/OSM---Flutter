import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm/data/models/frame_enums.dart';
import 'package:osm/services/color_api_service.dart';
import 'package:osm/services/save_image_to_app_directory.dart';
import 'package:osm/services/save_image_to_app_directory.dart';
import 'package:osm/widgets/build_text_field_widget.dart';
import 'package:osm/widgets/image_selector_widget.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../data/models/frame_model.dart';
import '../../widgets/custom_button.dart';

// Helper class to hold controllers and state for a single Frame variant form
class FrameVariantFormControllers {
  final TextEditingController sizeController;
  final TextEditingController quantityController;
  final TextEditingController purchasePriceController;
  final TextEditingController salesPriceController;
  final TextEditingController hexColorController;
  Color color;

  FrameVariantFormControllers({
    required this.sizeController,
    required this.quantityController,
    required this.purchasePriceController,
    required this.salesPriceController,
    required this.hexColorController,
    this.color = Colors.black,
  });

  void dispose() {
    sizeController.dispose();
    quantityController.dispose();
    purchasePriceController.dispose();
    salesPriceController.dispose();
    hexColorController.dispose();
  }
}

class FrameFormWidget extends StatefulWidget {
  final Function(FrameModel, List<FrameVariant>) onSubmit;

  const FrameFormWidget({super.key, required this.onSubmit});

  @override
  State<FrameFormWidget> createState() => _FrameFormWidgetState();
}

class _FrameFormWidgetState extends State<FrameFormWidget> {
  final _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();
  FrameType? _frameType;
  final List<File> _selectedImages = [];

  final _companyController = TextEditingController();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();

  final List<FrameVariantFormControllers> _variantControllers = [];

  @override
  void initState() {
    super.initState();
    _addVariant();
  }

  @override
  void dispose() {
    _companyController.dispose();
    _nameController.dispose();
    _codeController.dispose();
    for (var controllers in _variantControllers) {
      controllers.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _colorToHex(Color color) {
    return '${color.red.toRadixString(16).padLeft(2, '0')}'
            '${color.green.toRadixString(16).padLeft(2, '0')}'
            '${color.blue.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }

  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    try {
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return Colors.black;
    }
  }

  void _addVariant() {
    final defaultColor = Colors.black;
    final newControllers = FrameVariantFormControllers(
      sizeController: TextEditingController(text: '0'),
      quantityController: TextEditingController(text: '1'),
      purchasePriceController: TextEditingController(text: '0.0'),
      salesPriceController: TextEditingController(text: '0.0'),
      hexColorController: TextEditingController(
        text: _colorToHex(defaultColor),
      ),
      color: defaultColor,
    );

    newControllers.hexColorController.addListener(() {
      final text = newControllers.hexColorController.text;
      if (text.length == 6) {
        setState(() {
          newControllers.color = _hexToColor(text);
        });
      }
    });

    setState(() {
      _variantControllers.add(newControllers);
    });
  }

  void _removeVariant(int index) {
    if (_variantControllers.length > 1) {
      setState(() {
        _variantControllers[index].dispose();
        _variantControllers.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot remove the last variant.")),
      );
    }
  }

  // --- This method is from your ui-update branch ---
  void _pickColor(FrameVariantFormControllers controllers) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: controllers.color,
            onColorChanged: (color) {
              setState(() {
                controllers.color = color;
                controllers.hexColorController.text = _colorToHex(color);
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
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate() || _frameType == null) {
      // ... validation logic ...
      return;
    }

    // --- This block is from your main branch ---
    final List<String> permanentImagePaths = [];
    try {
      for (final tempImage in _selectedImages) {
        final savedPath = await saveImageToAppDirectory(tempImage);
        permanentImagePaths.add(savedPath);
      }
    } catch (e) {
      debugPrint("Error saving images to disk: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error saving images. Please try again."),
          ),
        );
      }
      return;
    }

    final List<String> permanentImagePaths = [];
    try {
      for (final tempImage in _selectedImages) {
        final savedPath = await saveImageToAppDirectory(tempImage);
        permanentImagePaths.add(savedPath);
      }
    } catch (e) {
      debugPrint("Error saving images to disk: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error saving images. Please try again."),
          ),
        );
      }
      return;
    }

    final List<String> permanentImagePaths = [];
    try {
      for (final tempImage in _selectedImages) {
        final savedPath = await saveImageToAppDirectory(tempImage);
        permanentImagePaths.add(savedPath);
      }
    } catch (e) {
      debugPrint("Error saving images to disk: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error saving images. Please try again."),
          ),
        );
      }
      return;
    }

    // --- This block is also from your main branch ---
    for (int i = 0; i < _variantControllers.length; i++) {
      final controllers = _variantControllers[i];
      if (controllers.color == Colors.black && i > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please select a color for Variant ${i + 1}."),
          ),
        );
        return;
      }
      if (int.tryParse(controllers.sizeController.text) == null ||
          int.tryParse(controllers.quantityController.text) == null ||
          double.tryParse(controllers.purchasePriceController.text) == null ||
          double.tryParse(controllers.salesPriceController.text) == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Please fill all valid numeric details for Variant ${i + 1} (size, quantity, prices).",
            ),
          ),
        );
        return;
      }
    }

    final String companyName = _companyController.text.trim();
    final String modelName = _nameController.text.trim();
    final String modelCode = _codeController.text.trim();

    final colorApiService = ColorApiService();

    final List<FrameVariant> variantsToSave = [];

    for (final controllers in _variantControllers) {
      final colorName = await colorApiService.getColorName(
        color: controllers.color,
      );

      final String computedProductCode = FrameVariant.generateProductCode(
        _frameType!,
        companyName,
        modelName,
        modelCode,
        colorName,
        int.parse(controllers.sizeController.text),
      );

      final FrameVariant variant = FrameVariant(
        code: modelCode,
        color: controllers.color,
        colorName: colorName,
        productCode: computedProductCode,
        size: int.parse(controllers.sizeController.text),
        quantity: int.parse(controllers.quantityController.text),
        purchasePrice: double.parse(controllers.purchasePriceController.text),
        salesPrice: double.parse(controllers.salesPriceController.text),
        imageUrls: permanentImagePaths, // Use the saved paths
        localImagesPaths: permanentImagePaths,
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

    await widget.onSubmit(frameModel, variantsToSave);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Frame stock saved successfully!")),
      );
    }
  }

  Widget _buildVariantForm(int index, FrameVariantFormControllers controllers) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Variant ${index + 1}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_variantControllers.length > 1)
                  IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () => _removeVariant(index),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controllers.hexColorController,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'Hex Color Code',
                      prefixText: '#',
                      counterText: "",
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => _pickColor(controllers),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controllers.color,
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            BuildTextFieldWidget(
              label: "Size",
              controller: controllers.sizeController,
              isNumeric: true,
            ),
            BuildTextFieldWidget(
              label: "Quantity",
              controller: controllers.quantityController,
              isNumeric: true,
            ),
            BuildTextFieldWidget(
              label: "Purchase Price",
              controller: controllers.purchasePriceController,
              isDecimal: true,
            ),
            BuildTextFieldWidget(
              label: "Sales Price",
              controller: controllers.salesPriceController,
              isDecimal: true,
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
              title: const Row(
                children: [Icon(Icons.calendar_month_outlined), Text('Date')],
              ),
              trailing: Text(
                DateFormat.yMMMd().format(_selectedDate),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<FrameType>(
              decoration: const InputDecoration(labelText: 'Frame Type'),
              value: _frameType,
              items: FrameType.values.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.name));
              }).toList(),
              onChanged: (type) => setState(() => _frameType = type),
              validator: (value) => value == null ? 'Select frame type' : null,
            ),
            const SizedBox(height: 16),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: _addVariant,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Variant"),
                ),
              ],
            ),
            const Divider(),
            ..._variantControllers.asMap().entries.map(
              (entry) => _buildVariantForm(entry.key, entry.value),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: _handleSubmit,
              label: 'Save Stock',
              icon: Icons.check,
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

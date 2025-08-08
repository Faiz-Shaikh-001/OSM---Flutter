import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm/data/models/frame_enums.dart';
import 'package:osm/services/color_api_service.dart';
import 'package:osm/services/save_image_to_app_directory.dart';
import 'package:osm/widgets/build_text_field_widget.dart';
import 'package:osm/widgets/image_selector_widget.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../data/models/frame_model.dart';
import '../../widgets/custom_button.dart';
// Remove MultiColorPicker import if no longer used after refactor

// 1. Helper class to hold controllers and state for a single Frame variant form
class FrameVariantFormControllers {
  final TextEditingController sizeController;
  final TextEditingController quantityController;
  final TextEditingController purchasePriceController;
  final TextEditingController salesPriceController;
  Color color; // Color for this variant
  String? colorName; // Name of the color (fetched from API)

  FrameVariantFormControllers({
    required this.sizeController,
    required this.quantityController,
    required this.purchasePriceController,
    required this.salesPriceController,
    this.color = Colors.black, // Default color
    this.colorName,
  });

  void dispose() {
    sizeController.dispose();
    quantityController.dispose();
    purchasePriceController.dispose();
    salesPriceController.dispose();
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
  final List<File> _selectedImages = []; // Top-level images for the FrameModel

  final _companyController = TextEditingController();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();

  // List to hold controllers for each dynamically added variant
  final List<FrameVariantFormControllers> _variantControllers =
      []; // Renamed from _variantForms

  @override
  void initState() {
    super.initState();
    // Initialize with one variant form by default
    _addVariant();
  }

  @override
  void dispose() {
    _companyController.dispose();
    _nameController.dispose();
    _codeController.dispose();
    // Dispose all controllers in the variant list
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
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _addVariant() {
    setState(() {
      _variantControllers.add(
        FrameVariantFormControllers(
          sizeController: TextEditingController(
            text: '0',
          ), // Default initial value
          quantityController: TextEditingController(
            text: '1',
          ), // Default quantity
          purchasePriceController: TextEditingController(
            text: '0.0',
          ), // Default price
          salesPriceController: TextEditingController(
            text: '0.0',
          ), // Default price
          color: Colors.black, // Default color for new variant
        ),
      );
    });
  }

  void _removeVariant(int index) {
    setState(() {
      // Only allow removing if there's more than one variant
      if (_variantControllers.length > 1) {
        _variantControllers[index]
            .dispose(); // Dispose controllers of the removed variant
        _variantControllers.removeAt(index);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cannot remove the last variant.")),
        );
      }
    });
  }

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate() || _frameType == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please fill all required fields and select a frame type.',
            ),
          ),
        );
      }
      return;
    }

    if (_variantControllers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add at least one variant.")),
      );
      return;
    }

    if (_selectedImages.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please upload at least one image for the product."),
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

    // Validate individual variant data
    for (int i = 0; i < _variantControllers.length; i++) {
      final controllers = _variantControllers[i];
      if (controllers.color == Colors.black && i > 0) {
        // Assuming default black needs to be changed
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
      if (int.parse(controllers.sizeController.text) <= 0 ||
          int.parse(controllers.quantityController.text) <= 0 ||
          double.parse(controllers.purchasePriceController.text) <= 0.0 ||
          double.parse(controllers.salesPriceController.text) <= 0.0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "All numeric fields for Variant ${i + 1} must be greater than zero.",
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
    final List<String> imageUrlsToSave = _selectedImages
        .map((file) => file.path)
        .toList();

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
        imageUrls:
            imageUrlsToSave, // All variants share the same top-level product images
        localImagesPaths: imageUrlsToSave, // Local paths for storage
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
      // Navigator.pop(context); // Decide if you want to pop here
    }
  }

  // Helper method to build a single variant form row
  Widget _buildVariantForm(int index, FrameVariantFormControllers controllers) {
    // Renamed from _buildVariantRow
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Consistent padding
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
                  ), // Larger font for variant title
                ),
                // Delete Button (only if more than one variant)
                if (_variantControllers.length > 1)
                  IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () => _removeVariant(index),
                  ),
              ],
            ),
            const SizedBox(height: 16), // Spacing after variant title
            // Color selector row
            Row(
              children: [
                const Text("Color:"),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    final Color? selectedColor = await showDialog<Color>(
                      // Renamed variable
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Pick a color"),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor:
                                controllers.color, // Use controller's color
                            onColorChanged: (c) => controllers.color =
                                c, // Update controller's color
                            enableAlpha: false,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(
                              controllers.color,
                            ), // Pop with controller's color
                            child: const Text("Done"),
                          ),
                        ],
                      ),
                    );
                    if (selectedColor != null) {
                      setState(
                        () => controllers.color = selectedColor,
                      ); // Trigger rebuild to show new color
                    }
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controllers.color, // Display controller's color
                      border: Border.all(),
                    ),
                  ),
                ),
                const Spacer(), // Pushes color picker to the left, delete button to the right
              ],
            ),
            const SizedBox(height: 16), // Spacing after color row
            // TextFormFields using BuildTextFieldWidget and controllers
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
            // Image Selector for the main product (FrameModel)
            ImageSelectorWidget(
              selectedImages: _selectedImages,
              onImagesChanged: (imgs) => setState(
                () => _selectedImages
                  ..clear()
                  ..addAll(imgs),
              ),
            ),
            const SizedBox(height: 10),

            // Date Picker
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
            const SizedBox(height: 10), // Added spacing
            // Frame Type Dropdown
            DropdownButtonFormField<FrameType>(
              decoration: const InputDecoration(labelText: 'Frame Type'),
              value: _frameType,
              items: FrameType.values.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.name));
              }).toList(),
              onChanged: (type) => setState(() => _frameType = type),
              validator: (value) => value == null ? 'Select frame type' : null,
            ),
            const SizedBox(height: 16), // Added spacing
            // Main product details (Company, Model Name, Code) using BuildTextFieldWidget
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ), // Adjusted font size
                ),
                TextButton.icon(
                  onPressed: _addVariant,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Variant"),
                ),
              ],
            ),
            const Divider(), // Added divider for visual separation
            // Dynamically generated variant forms
            ..._variantControllers.asMap().entries.map(
              (entry) => _buildVariantForm(
                entry.key,
                entry.value,
              ), // Pass controller to helper
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: _handleSubmit,
              label: 'Save Stock',
              icon: Icons.check,
            ),
            const SizedBox(height: 15), // Consistent spacing
          ],
        ),
      ),
    );
  }
}

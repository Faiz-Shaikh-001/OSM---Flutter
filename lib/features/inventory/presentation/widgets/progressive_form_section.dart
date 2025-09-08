import 'package:flutter/material.dart';
import 'package:osm/features/inventory/data/models/lens_enums.dart';
import 'package:osm/features/inventory/data/models/lens_model.dart';
import 'package:osm/core/widgets/build_text_field_widget.dart';
import 'package:osm/core/widgets/button_increment_decrement_widget.dart';
import 'package:osm/core/widgets/custom_button.dart';
import 'package:osm/core/widgets/image_selector.dart';
import 'dart:io';

// Helper class to hold controllers and state for a single Progressive lens variant form
class ProgressiveLensVariantFormControllers {
  final TextEditingController indexController;
  final TextEditingController diameterController;
  final TextEditingController sphericalController;
  final TextEditingController cylindricalController;
  final TextEditingController axisController;
  final TextEditingController addController;
  final TextEditingController baseCurveController; // New for Progressive
  final TextEditingController pairController;
  final TextEditingController purchasePriceController;
  final TextEditingController salesPriceController;
  LensMaterialType? materialType;
  ProgressiveLensSide? side; // New for Progressive

  ProgressiveLensVariantFormControllers({
    required this.indexController,
    required this.diameterController,
    required this.sphericalController,
    required this.cylindricalController,
    required this.axisController,
    required this.addController,
    required this.baseCurveController,
    required this.pairController,
    required this.purchasePriceController,
    required this.salesPriceController,
    this.materialType,
    this.side,
  });

  void dispose() {
    indexController.dispose();
    diameterController.dispose();
    sphericalController.dispose();
    cylindricalController.dispose();
    axisController.dispose();
    addController.dispose();
    baseCurveController.dispose();
    pairController.dispose();
    purchasePriceController.dispose();
    salesPriceController.dispose();
  }
}

class ProgressiveFormSection extends StatefulWidget {
  final Future<void> Function(LensModel lens, List<LensVariant> variants)
  onSubmit;

  const ProgressiveFormSection({super.key, required this.onSubmit});

  @override
  State<ProgressiveFormSection> createState() => _ProgressiveFormSectionState();
}

class _ProgressiveFormSectionState extends State<ProgressiveFormSection> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final List<File> _selectedImages = [];

  final List<ProgressiveLensVariantFormControllers> _variantControllers = [];

  @override
  void initState() {
    super.initState();
    _addVariant(); // Start with one variant form by default
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _productNameController.dispose();
    for (var controllers in _variantControllers) {
      controllers.dispose();
    }
    super.dispose();
  }

  void _addVariant() {
    setState(() {
      _variantControllers.add(
        ProgressiveLensVariantFormControllers(
          indexController: TextEditingController(),
          diameterController: TextEditingController(),
          sphericalController: TextEditingController(),
          cylindricalController: TextEditingController(),
          axisController: TextEditingController(),
          addController: TextEditingController(),
          baseCurveController: TextEditingController(),
          pairController: TextEditingController(text: '1'),
          purchasePriceController: TextEditingController(),
          salesPriceController: TextEditingController(),
        ),
      );
    });
  }

  void _removeVariant(int index) {
    setState(() {
      _variantControllers[index].dispose();
      _variantControllers.removeAt(index);
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final List<LensVariant> variants = [];
      for (var controllers in _variantControllers) {
        final List<String> variantImageUrls = _selectedImages
            .map((file) => file.path)
            .toList();

        final lensVariant = LensVariant(
          spherical: double.tryParse(controllers.sphericalController.text),
          cylindrical: double.tryParse(controllers.cylindricalController.text),
          axis: int.tryParse(controllers.axisController.text),
          add: double.tryParse(controllers.addController.text),
          baseCurve: int.tryParse(
            controllers.baseCurveController.text,
          ), // New field
          diameter: int.tryParse(controllers.diameterController.text),
          pair: int.tryParse(controllers.pairController.text),
          purchasePrice: double.tryParse(
            controllers.purchasePriceController.text,
          ),
          salesPrice: double.tryParse(controllers.salesPriceController.text),
          materialType: controllers.materialType,
          index: int.tryParse(controllers.indexController.text),
          side: controllers.side, // New field
          quantity: int.tryParse(controllers.pairController.text),
          imageUrls: variantImageUrls,
        );

        final productCode = LensVariant.generateProductCode(
          _companyNameController.text,
          _productNameController.text,
          LensType.progressive, // Specific to this form
          lensVariant.spherical ?? 0.0,
          lensVariant.cylindrical ?? 0.0,
          lensVariant.diameter ?? 0,
          lensVariant.materialType,
          lensVariant.index,
          lensVariant.axis,
          lensVariant.add,
          lensVariant.baseCurve,
          lensVariant.side,
        );
        variants.add(lensVariant.copyWith(productCode: productCode));
      }

      final lensModel = LensModel(
        companyName: _companyNameController.text,
        productName: _productNameController.text,
        lensType: LensType.progressive, // Specific to this form
        variants: variants,
      );

      await widget.onSubmit(lensModel, variants);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BuildTextFieldWidget(
            controller: _companyNameController,
            label: "Company Name",
          ),
          BuildTextFieldWidget(
            controller: _productNameController,
            label: "Product Name",
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Variants",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            onPressed: _submitForm,
            label: "Submit All Lenses",
            icon: Icons.check,
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  // Helper method to build a single variant form
  Widget _buildVariantForm(
    int index,
    ProgressiveLensVariantFormControllers controllers,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Variant ${index + 1}',
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
            ImageSelectorWidget(
              selectedImages: _selectedImages,
              onImagesChanged: (imgs) {
                setState(() {
                  _selectedImages
                    ..clear()
                    ..addAll(imgs);
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<LensMaterialType>(
              decoration: const InputDecoration(
                labelText: 'Material Type',
                border: OutlineInputBorder(),
              ),
              value: controllers.materialType,
              items: LensMaterialType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.displayName),
                );
              }).toList(),
              onChanged: (type) =>
                  setState(() => controllers.materialType = type),
              validator: (value) =>
                  value == null ? 'Select Material Type' : null,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .40,
                  child: BuildTextFieldWidget(
                    isDecimal: true,
                    controller: controllers.indexController,
                    label: "Index",
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .40,
                  child: BuildTextFieldWidget(
                    isDecimal: true,
                    controller: controllers.diameterController,
                    label: "DIA",
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .40,
                  child: BuildTextFieldWidget(
                    isDecimal: true,
                    controller: controllers.sphericalController,
                    label: "SPH",
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .40,
                  child: BuildTextFieldWidget(
                    isDecimal: true,
                    controller: controllers.cylindricalController,
                    label: "CYL",
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .40,
                  child: BuildTextFieldWidget(
                    isDecimal: true,
                    controller: controllers.axisController,
                    label: "Axis",
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .40,
                  child: BuildTextFieldWidget(
                    isDecimal: true,
                    controller: controllers.addController,
                    label: "ADD",
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .40,
                  child: BuildTextFieldWidget(
                    isDecimal: true,
                    controller: controllers.baseCurveController,
                    label: "Base Curve",
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .40,
                  child: DropdownButtonFormField<ProgressiveLensSide>(
                    decoration: const InputDecoration(
                      labelText: 'Select Side',
                      border: OutlineInputBorder(),
                    ),
                    value: controllers.side,
                    items: ProgressiveLensSide.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.displayName),
                      );
                    }).toList(),
                    onChanged: (type) =>
                        setState(() => controllers.side = type),
                    validator: (value) => value == null ? 'Select Side' : null,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .40,
                  child: BuildTextFieldWidget(
                    controller: controllers.pairController,
                    label: "Pair Quantity",
                  ),
                ),
                ButtonCounter(controller: controllers.pairController),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .40,
                  child: BuildTextFieldWidget(
                    controller: controllers.purchasePriceController,
                    label: "Purchase Price",
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .40,
                  child: BuildTextFieldWidget(
                    controller: controllers.salesPriceController,
                    label: "Sales Price",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

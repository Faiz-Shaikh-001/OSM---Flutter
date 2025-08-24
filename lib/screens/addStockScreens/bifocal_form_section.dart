import 'dart:math';

import 'package:flutter/material.dart';
import 'package:osm/data/models/lens_enums.dart';
import 'package:osm/widgets/build_text_field_widget.dart';
import 'package:osm/widgets/button_increment_decrement_widget.dart';
import 'package:osm/widgets/custom_button.dart';
import 'package:osm/widgets/image_selector_widget.dart';
import 'dart:io';

import '../../data/models/lens_model.dart';

class BifocalLensVariantFormControllers {
  final TextEditingController indexController;
  final TextEditingController diameterController;
  final TextEditingController sphericalController;
  final TextEditingController cylindricalController;
  final TextEditingController axisController;
  final TextEditingController addController;
  final TextEditingController pairController;
  final TextEditingController purchasePriceController;
  final TextEditingController salesPriceController;
  LensMaterialType? materialType; // Material type for this variant

  BifocalLensVariantFormControllers({
    required this.indexController,
    required this.diameterController,
    required this.sphericalController,
    required this.cylindricalController,
    required this.axisController,
    required this.addController,
    required this.pairController,
    required this.purchasePriceController,
    required this.salesPriceController,
    this.materialType,
  });

  void dispose() {
    indexController.dispose();
    diameterController.dispose();
    sphericalController.dispose();
    cylindricalController.dispose();
    axisController.dispose();
    addController.dispose();
    pairController.dispose();
    purchasePriceController.dispose();
    salesPriceController.dispose();
  }
}

class BifocalFormSection extends StatefulWidget {
  final Future<void> Function(LensModel lens, List<LensVariant> variants)
  onSubmit;

  const BifocalFormSection({super.key, required this.onSubmit});

  @override
  State<BifocalFormSection> createState() => _BifocalFormSectionState();
}

class _BifocalFormSectionState extends State<BifocalFormSection> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();

  final List<File> _selectedImages = [];
  final List<BifocalLensVariantFormControllers> _variantControllers = [];

  @override
  void initState() {
    super.initState();
    _addVariant();
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
        BifocalLensVariantFormControllers(
          indexController: TextEditingController(),
          diameterController: TextEditingController(),
          sphericalController: TextEditingController(),
          cylindricalController: TextEditingController(),
          axisController: TextEditingController(),
          addController: TextEditingController(),
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

      final List<String> modelImageUrls = _selectedImages
          .map((file) => file.path)
          .toList();

      final List<LensVariant> variants = [];
      for (var controllers in _variantControllers) {
        final lensVariant = LensVariant(
          spherical: double.tryParse(controllers.sphericalController.text),
          cylindrical: double.tryParse(controllers.cylindricalController.text),
          pair: int.tryParse(controllers.pairController.text),
          diameter: int.tryParse(controllers.diameterController.text),
          axis: int.tryParse(controllers.axisController.text),
          add: double.tryParse(controllers.addController.text),
          purchasePrice: double.tryParse(
            controllers.purchasePriceController.text,
          ),
          salesPrice: double.tryParse(controllers.salesPriceController.text),
          materialType: controllers.materialType,
          index: int.tryParse(controllers.indexController.text),
          quantity: int.tryParse(controllers.pairController.text),
        );

        final productCode = LensVariant.generateProductCode(
          _companyNameController.text,
          _productNameController.text,
          LensType.bifocal,
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
        lensType: LensType.bifocal,
        variants: variants,
        imageUrls: modelImageUrls,
      );

      await widget.onSubmit(lensModel, variants);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
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
            const SizedBox(height: 16),

            BuildTextFieldWidget(
              controller: _companyNameController,
              label: "Company Name",
            ),
            BuildTextFieldWidget(
              controller: _productNameController,
              label: "Product Name",
            ),
            const SizedBox(height: 20),

            // --- Variants Section Header and Add Button ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Variants",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: _addVariant,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Variant"),
                ),
              ],
            ),
            const Divider(),
            // --- Dynamic Variant Forms ---
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
      ),
    );
  }

  Widget _buildVariantForm(
    int index,
    BifocalLensVariantFormControllers controllers,
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
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Material Type'),
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

            // --- FIXED LAYOUT ---
            Row(
              children: [
                Expanded(
                  child: BuildTextFieldWidget(
                    isDecimal: true,
                    controller: controllers.indexController,
                    label: "Index",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BuildTextFieldWidget(
                    isDecimal: true,
                    controller: controllers.diameterController,
                    label: "DIA",
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: BuildTextFieldWidget(
                    isDecimal: true,
                    controller: controllers.sphericalController,
                    label: "SPH",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BuildTextFieldWidget(
                    isDecimal: true,
                    controller: controllers.cylindricalController,
                    label: "CYL",
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: BuildTextFieldWidget(
                    isDecimal: true,
                    controller: controllers.axisController,
                    label: "Axis",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BuildTextFieldWidget(
                    isDecimal: true,
                    controller: controllers.addController,
                    label: "ADD",
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: BuildTextFieldWidget(
                    controller: controllers.pairController,
                    label: "Pair",
                  ),
                ),
                ButtonCounter(controller: controllers.pairController),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: BuildTextFieldWidget(
                    controller: controllers.purchasePriceController,
                    label: "Purchase Price",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
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

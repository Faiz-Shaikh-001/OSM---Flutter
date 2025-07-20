import 'package:flutter/material.dart';
import 'package:osm/pages/addStockScreens/bifocal_form_section.dart';
import 'package:osm/pages/addStockScreens/contact_lens_form_section.dart';
import 'package:osm/pages/addStockScreens/frame_form_widget.dart';
import 'package:osm/pages/addStockScreens/progressive_form_section.dart';
import 'package:osm/pages/addStockScreens/single_vision_form_section.dart';
import 'dart:io';
import '../../models/frame_model.dart';

enum ProductType {
  frame,
  singleVisionLens,
  bifocalLens,
  progressiveLens,
  contactLens,
}

extension ProductTypeExtension on ProductType {
  String get label {
    switch (this) {
      case ProductType.frame:
        return 'Frame';
      case ProductType.singleVisionLens:
        return 'Single Vision Lens';
      case ProductType.bifocalLens:
        return 'Bifocal Lens';
      case ProductType.progressiveLens:
        return 'Progressive Lens';
      case ProductType.contactLens:
        return 'Contact Lens';
    }
  }
}

class AddStockScreen extends StatefulWidget {
  const AddStockScreen({super.key});

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  ProductType? selectedType;

  final List<ProductType> productTypes = ProductType.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Stock'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              top: 16,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedType?.label,
                    decoration: const InputDecoration(
                      labelText: 'Select Product Type',
                      border: OutlineInputBorder(),
                    ),
                    items: productTypes.map((type) {
                      return DropdownMenuItem(
                        value: type.label,
                        child: Text(type.label),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedType = productTypes.firstWhere(
                          (type) => type.label == value,
                          orElse: () => ProductType.frame,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  if (selectedType != null) _buildForm(selectedType!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildForm(ProductType type) {
    switch (type) {
      case ProductType.frame:
        return AddFrameFormSection();
      case ProductType.singleVisionLens:
        return SingleVisionFormSection();
      case ProductType.bifocalLens:
        return BifocalFormSection();
      case ProductType.progressiveLens:
        return ProgressiveFormSection();
      case ProductType.contactLens:
        return ContactLensFormSection();
    }
  }
}

class AddFrameFormSection extends StatelessWidget {
  const AddFrameFormSection({super.key});

  void _handleSubmit(FrameModel frame, List<FrameVariant> variants) {
    // Handle saving to backend or DB
    // You can also use the variants list as needed
  }

  @override
  Widget build(BuildContext context) {
    return FrameFormWidget(onSubmit: _handleSubmit);
  }
}

// class AddSingleVisionFormSection extends StatelessWidget {
//   const AddSingleVisionFormSection({super.key});

//   void _handleSubmit({required DateTime date}) {}

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

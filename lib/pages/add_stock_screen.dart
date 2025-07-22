import 'package:flutter/material.dart';
import 'package:osm/widgets/frame_form_widget.dart';
import 'dart:io';
import '../models/frame_model.dart';

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
        return const Text("Single Vision form goes here");
      case ProductType.bifocalLens:
        return const Text("Bifocal form goes here");
      case ProductType.progressiveLens:
        return const Text("Progressive form goes here");
      case ProductType.contactLens:
        return const Text("Contact Lens form goes here");
    }
  }
}

class AddFrameFormSection extends StatelessWidget {
  const AddFrameFormSection({super.key});

  void _handleSubmit({
    required DateTime date,
    required FrameType frameType,
    required String name,
    required String code,
    required Color color,
    required int size,
    required int quantity,
    required double purchasePrice,
    required double salesPrice,
    required List<File> images,
  }) {
    // Handle saving to backend or DB
    print('Saving Frame: $name ($code), $quantity pcs');
  }

  @override
  Widget build(BuildContext context) {
    return BuildFrameForm(onSubmit: _handleSubmit);
  }
}

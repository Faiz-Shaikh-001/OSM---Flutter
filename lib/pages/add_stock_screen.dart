import 'package:flutter/material.dart';
import 'package:osm/widgets/frame_form_widget.dart';
import 'dart:io';
import '../models/frame_model.dart';

class AddStockScreen extends StatefulWidget {
  const AddStockScreen({super.key});

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  String? selectedType;

  final List<String> productTypes = [
    'Frame',
    'Single Vision Lens',
    'Bifocal Lens',
    'Progressive Lens',
    'Contact Lens',
  ];

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
                    value: selectedType,
                    decoration: const InputDecoration(
                      labelText: 'Select Product Type',
                      border: OutlineInputBorder(),
                    ),
                    items: productTypes.map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
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

  Widget _buildForm(String type) {
    switch (type) {
      case 'Frame':
        return AddFrameStockScreen();
      case 'Single Vision Lens':
        return const Text("Single Vision form goes here");
      case 'Bifocal Lens':
        return const Text("Bifocal form goes here");
      case 'Progressive Lens':
        return const Text("Progressive form goes here");
      case 'Contact Lens':
        return const Text("Contact Lens form goes here");
      default:
        return const SizedBox();
    }
  }
}

class AddFrameStockScreen extends StatelessWidget {
  const AddFrameStockScreen({super.key});

  void _handleSubmit({
    required DateTime date,
    required FrameType frameType,
    required String name,
    required String code,
    required String color,
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

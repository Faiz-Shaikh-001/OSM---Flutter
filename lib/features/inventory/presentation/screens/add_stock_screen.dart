import 'package:flutter/material.dart';
import 'package:osm/features/inventory/data/models/lens_enums.dart';
import 'package:osm/features/inventory/data/models/lens_model.dart';
import 'package:osm/features/inventory/presentation/widgets/bifocal_form_section.dart';
import 'package:osm/features/inventory/presentation/widgets/contact_lens_form_section.dart';
import 'package:osm/features/inventory/presentation/widgets/frame_form_widget.dart';
import 'package:osm/features/inventory/presentation/widgets/progressive_form_section.dart';
import 'package:osm/features/inventory/presentation/widgets/single_vision_form_section.dart';
import 'package:osm/features/inventory/viewmodels/frame_viewmodel.dart';
import 'package:osm/features/inventory/viewmodels/lens_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../data/models/frame_model.dart';

enum ProductTypeToAdd {
  frame,
  singleVisionLens,
  bifocalLens,
  progressiveLens,
  contactLens,
}

extension ProductTypeExtension on ProductTypeToAdd {
  String get label {
    switch (this) {
      case ProductTypeToAdd.frame:
        return 'Frame';
      case ProductTypeToAdd.singleVisionLens:
        return 'Single Vision Lens';
      case ProductTypeToAdd.bifocalLens:
        return 'Bifocal Lens';
      case ProductTypeToAdd.progressiveLens:
        return 'Progressive Lens';
      case ProductTypeToAdd.contactLens:
        return 'Contact Lens';
    }
  }

  LensType? toLensType() {
    switch (this) {
      case ProductTypeToAdd.singleVisionLens:
        return LensType.singleVision;
      case ProductTypeToAdd.bifocalLens:
        return LensType.bifocal;
      case ProductTypeToAdd.progressiveLens:
        return LensType.progressive;
      case ProductTypeToAdd.contactLens:
        return LensType.contactLens;
      default:
        return null;
    }
  }
}

class AddStockScreen extends StatefulWidget {
  const AddStockScreen({super.key});

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  ProductTypeToAdd? selectedType;

  final List<ProductTypeToAdd> productTypes = ProductTypeToAdd.values;

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
                          orElse: () => ProductTypeToAdd.frame,
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

  Widget _buildForm(ProductTypeToAdd type) {
    switch (type) {
      case ProductTypeToAdd.frame:
        return AddFrameFormSection();
      case ProductTypeToAdd.singleVisionLens:
        return AddLensFormSection(lensType: LensType.singleVision);
      case ProductTypeToAdd.bifocalLens:
        return AddLensFormSection(lensType: LensType.bifocal);
      case ProductTypeToAdd.progressiveLens:
        return AddLensFormSection(lensType: LensType.progressive);
      case ProductTypeToAdd.contactLens:
        return AddLensFormSection(lensType: LensType.contactLens);
    }
  }
}

// ---- Frame Form Section ----
class AddFrameFormSection extends StatelessWidget {
  const AddFrameFormSection({super.key});

  void _handleSubmit(
    BuildContext context,
    FrameModel frame,
    List<FrameVariant> variants,
  ) async {
    final frameViewModel = context.read<FrameViewmodel>();

    try {
      final newFrame = frame.copyWith(variants: variants);
      await frameViewModel.addFrame(newFrame);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Frame added successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add frame: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FrameFormWidget(
      onSubmit: (frame, variants) => _handleSubmit(context, frame, variants),
    );
  }
}

// ---- Generic Lens Form Section ----
class AddLensFormSection extends StatelessWidget {
  final LensType lensType;
  const AddLensFormSection({super.key, required this.lensType});

  Future<void> _handleSubmit(
    BuildContext context,
    LensModel lens,
    List<LensVariant> variants,
  ) async {
    final lensViewModel = context.read<LensViewmodel>();

    try {
      final newLens = lens.copyWith(variants: variants);
      await lensViewModel.addLens(newLens);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${lensType.displayName} added successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to add ${lensType.displayName}: ${e.toString()}',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (lensType) {
      case LensType.singleVision:
        return SingleVisionFormSection(
          onSubmit: (lens, variants) => _handleSubmit(context, lens, variants),
        );
      case LensType.bifocal:
        return BifocalFormSection(
          onSubmit: (lens, variants) => _handleSubmit(context, lens, variants),
        );
      case LensType.progressive:
        return ProgressiveFormSection(
          onSubmit: (lens, variants) => _handleSubmit(context, lens, variants),
        );
      case LensType.contactLens:
        return ContactLensFormSection(
          onSubmit: (lens, variants) => _handleSubmit(context, lens, variants),
        );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:osm/core/widgets/custom_button.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame_type.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame_variant.dart';
import 'package:osm/features/inventory/presentation/dto/create_frame_input.dart';
import 'package:osm/features/inventory/presentation/dto/frame_variant_input.dart';
import 'package:osm/features/inventory/presentation/screens/add_stock/forms/add_frame_variant_sheet.dart';
import 'package:uuid/uuid.dart';

class FrameFormWidget extends StatefulWidget {
  final Frame? initialFrame;
  final bool isEdit;
  final ValueChanged<Frame> onUpdate;
  final ValueChanged<CreateFrameInput> onCreate;
  const FrameFormWidget({
    super.key,
    required this.onCreate,
    required this.onUpdate,
    this.initialFrame,
    this.isEdit = false,
  });

  @override
  State<FrameFormWidget> createState() => _FrameFormWidgetState();
}

class _FrameFormWidgetState extends State<FrameFormWidget> {
  final _formKey = GlobalKey<FormState>();

  final _companyCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  FrameType _type = FrameType.fullMetal;
  final _customTypeController = TextEditingController();

  final List<FrameVariantInput> _variantInputs = [];

  @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.initialFrame != null) {
      final frame = widget.initialFrame!;

      _companyCtrl.text = frame.companyName;
      _nameCtrl.text = frame.name;
      _type = frame.type;

      if (frame.type == FrameType.custom && frame.customTypeName != null) {
        _customTypeController.text = frame.customTypeName!;
      }

      for (final variant in frame.variants) {
        _variantInputs.add(
          FrameVariantInput(
            productCode: variant.productCode,
            colorName: variant.colorName,
            colorValue: variant.colorValue,
            size: variant.size,
            quantity: variant.quantity,
            purchasePrice: variant.purchasePrice,
            salesPrice: variant.salesPrice,
            imageUrls: variant.imageUrls,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _companyCtrl.dispose();
    _nameCtrl.dispose();
    _customTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFrameInfoSection(),
          const SizedBox(height: 24),

          _buildVariantHeader(),
          _buildVariantList(),

          const SizedBox(height: 24),
          CustomButton(
            label: widget.isEdit ? 'Update Frame' : 'Save Frame',
            onPressed: () => _submit,
            icon: Icons.save,
          ),
        ],
      ),
    );
  }

  Widget _buildFrameInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _companyCtrl,
          decoration: const InputDecoration(labelText: 'Company Name'),
          validator: (v) =>
              v == null || v.isEmpty ? 'Company name required' : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _nameCtrl,
          decoration: const InputDecoration(labelText: 'Frame Name'),
          validator: (v) =>
              v == null || v.isEmpty ? 'Frame name required' : null,
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<FrameType>(
          initialValue: _type,
          items: FrameType.values
              .map(
                (type) =>
                    DropdownMenuItem(value: type, child: Text(type.label)),
              )
              .toList(),
          onChanged: widget.isEdit ? null : (v) => setState(() => _type = v!),
        ),

        if (_type == FrameType.custom) ...[
          const SizedBox(height: 12),
          TextFormField(
            controller: _customTypeController,
            decoration: const InputDecoration(labelText: 'Custom Frame Type'),
            validator: (v) =>
                v == null || v.isEmpty ? 'Custom type required' : null,
          ),
        ],
      ],
    );
  }

  Widget _buildVariantHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Variants',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ElevatedButton.icon(
          onPressed: _openAddVariantSheet,
          icon: const Icon(Icons.add),
          label: const Text('Add Variant'),
        ),
      ],
    );
  }

  Widget _buildVariantList() {
    if (_variantInputs.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text('No variants added'),
      );
    }

    return Column(
      children: _variantInputs.map((v) {
        return Card(
          child: ListTile(
            title: Text('${v.colorName} • Size ${v.size}'),
            subtitle: Text('Qty: ${v.quantity} | ₹${v.salesPrice}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() => _variantInputs.remove(v));
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  void _openAddVariantSheet() async {
    final variant = await showModalBottomSheet<FrameVariantInput>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const AddFrameVariantSheet(),
    );

    if (variant != null) {
      setState(() => _variantInputs.add(variant));
    }
  }

  List<FrameVariant> _mergeVariants(
    List<FrameVariant> oldVariants,
    List<FrameVariantInput> inputs,
  ) {
    final List<FrameVariant> result = [];

    for (final input in inputs) {
      final existing = oldVariants
          .where((v) => v.productCode == input.productCode)
          .cast<FrameVariant?>()
          .firstWhere((v) => v != null, orElse: () => null);

      if (existing != null) {
        result.add(
          FrameVariant(
            sku: existing.sku,
            productCode: existing.productCode,
            colorName: input.colorName,
            colorValue: input.colorValue,
            size: input.size,
            quantity: input.quantity,
            purchasePrice: input.purchasePrice,
            salesPrice: input.salesPrice,
            imageUrls: input.imageUrls,
          ),
        );
      } else {
        result.add(
          FrameVariant(
            sku: '',
            productCode: input.productCode,
            colorName: input.colorName,
            colorValue: input.colorValue,
            size: input.size,
            quantity: input.quantity,
            purchasePrice: input.purchasePrice,
            salesPrice: input.salesPrice,
            imageUrls: input.imageUrls,
          ),
        );
      }
    }

    return result;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_variantInputs.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Add at least one variant')));
      return;
    }

    if (widget.isEdit && widget.initialFrame != null) {
      final old = widget.initialFrame!;

      final updatedVariants = _mergeVariants(old.variants, _variantInputs);

      final updated = Frame(
        id: old.id,
        createdAt: old.createdAt,
        companyName: _companyCtrl.text.trim(),
        name: _nameCtrl.text.trim(),
        type: _type,
        customTypeName: _type == FrameType.custom
            ? _customTypeController.text.trim()
            : null,
        variants: updatedVariants,
        qrKey: old.qrKey,
      );

      widget.onUpdate(updated);
    } else {
      final qrKey = const Uuid().v4();

      final input = CreateFrameInput(
        qrKey: qrKey,
        companyName: _companyCtrl.text.trim(),
        name: _nameCtrl.text.trim(),
        type: _type,
        customTypeName: _type == FrameType.custom
            ? _customTypeController.text.trim()
            : null,
        variants: List.from(_variantInputs),
      );

      widget.onCreate(input);
    }
  }
}

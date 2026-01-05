import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/services/save_image_to_app_directory.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/core/widgets/custom_button.dart';
import 'package:osm/core/widgets/image_selector.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens_type.dart';
import 'package:osm/features/inventory/presentation/blocs/lens/lens_detail/lens_detail_bloc.dart';
import 'package:osm/features/inventory/presentation/blocs/lens/lens_list/lens_list_bloc.dart';
import 'package:osm/features/inventory/presentation/dto/create_lens_input.dart';
import 'package:uuid/uuid.dart';

class AddLensFormSection extends StatefulWidget {
  final bool isEdit;
  final LensId? lensId;
  final ValueChanged<CreateLensInput> onCreate;
  final ValueChanged<Lens> onUpdate;

  const AddLensFormSection({
    super.key,
    this.isEdit = false,
    this.lensId,
    required this.onCreate,
    required this.onUpdate,
  });

  @override
  State<AddLensFormSection> createState() => _AddLensFormSectionState();
}

class _AddLensFormSectionState extends State<AddLensFormSection> {
  final _formKey = GlobalKey<FormState>();

  final _companyCtrl = TextEditingController();
  final _productCtrl = TextEditingController();
  final _minIndexCtrl = TextEditingController();
  final _maxIndexCtrl = TextEditingController();
  final _purchasePriceCtrl = TextEditingController();
  final _salesPriceCtrl = TextEditingController();
  final _productCodeCtrl = TextEditingController();
  final _coatingsCtrl = TextEditingController();

  LensType? _selectedLensType;

  final Set<LensMaterialType> _materials = {};
  final List<String> _coatings = [];
  final List<File> _images = [];

  bool _isSaving = false;

  Lens? _initialLens;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.lensId != null) {
      context.read<LensDetailBloc>().add(GetLensByIdEvent(widget.lensId!));
    }
  }

  @override
  void dispose() {
    _coatingsCtrl.dispose();
    _purchasePriceCtrl.dispose();
    _salesPriceCtrl.dispose();
    _productCodeCtrl.dispose();
    _companyCtrl.dispose();
    _productCtrl.dispose();
    _minIndexCtrl.dispose();
    _maxIndexCtrl.dispose();
    super.dispose();
  }

  void _prefill(Lens lens) {
    _initialLens = lens;

    _companyCtrl.text = lens.companyName;
    _productCtrl.text = lens.productName;
    _minIndexCtrl.text = lens.minIndex.toString();
    _maxIndexCtrl.text = lens.maxIndex.toString();

    _selectedLensType = lens.lensType;
    _materials.addAll(lens.supportedMaterials);
    _coatings.addAll(lens.supportedCoatings);
    _purchasePriceCtrl.text = lens.purchasePrice.value.toString();
    _salesPriceCtrl.text = lens.salesPrice.value.toString();
    _productCodeCtrl.text = lens.productCode ?? '';

    _images.addAll(lens.imageUrls.map((p) => File(p)));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedLensType == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select lens type')));
      return;
    }

    setState(() => _isSaving = true);

    final List<String> imageUrls = [];
    for (final img in _images) {
      final path = await saveImageToAppDirectory(img);
      imageUrls.add(path);
    }

    if (widget.isEdit && _initialLens != null) {
      final old = _initialLens!;

      final updated = Lens(
        id: old.id,
        createdAt: old.createdAt,
        companyName: _companyCtrl.text.trim(),
        productName: _productCtrl.text.trim(),
        productCode: _productCodeCtrl.text.trim(),
        lensType: _selectedLensType!,
        supportedMaterials: _materials.toList(),
        minIndex: double.parse(_minIndexCtrl.text),
        maxIndex: double.parse(_maxIndexCtrl.text),
        supportedCoatings: _coatings,
        imageUrls: imageUrls,
        isActive: old.isActive,
        purchasePrice: Money(double.parse(_purchasePriceCtrl.text)),
        salesPrice: Money(double.parse(_salesPriceCtrl.text)),
        sku: old.sku,
        qrKey: old.qrKey,
      );
      widget.onUpdate(updated);
    } else {
      final qrKey = const Uuid().v4();

      final input = CreateLensInput(
        qrKey: qrKey,
        companyName: _companyCtrl.text.trim(),
        productName: _productCtrl.text.trim(),
        lensType: _selectedLensType!,
        supportedMaterials: _materials.toList(),
        minIndex: double.parse(_minIndexCtrl.text),
        maxIndex: double.parse(_maxIndexCtrl.text),
        supportedCoatings: _coatings,
        imageUrls: imageUrls,
        isActive: true,
        purchasePrice: Money(double.parse(_purchasePriceCtrl.text)),
        salesPrice: Money(double.parse(_salesPriceCtrl.text)),
        productCode: _productCodeCtrl.text.trim(),
      );
      widget.onCreate(input);
    }

    setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LensListBloc, LensListState>(
          listener: (context, state) {
            if (state is LensListActionSuccess) {
              Navigator.pop(context);
            }
            if (state is LensListError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: BlocBuilder<LensDetailBloc, LensDetailState>(
        builder: (context, state) {
          if (widget.isEdit) {
            if (state is LensDetailLoading && _initialLens == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is LensDetailLoaded && _initialLens == null) {
              _prefill(state.lens);
            }

            if (state is LensDetailError) {
              return Center(child: Text(state.message));
            }
          }

          return _buildForm();
        },
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageSelectorWidget(
              selectedImages: _images,
              onImagesChanged: (imgs) {
                setState(() {
                  _images
                    ..clear()
                    ..addAll(imgs);
                });
              },
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<LensType>(
              initialValue: _selectedLensType,
              decoration: const InputDecoration(labelText: 'Lens Type'),
              items: LensType.values.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.label));
              }).toList(),
              onChanged: widget.isEdit
                  ? null
                  : (v) => setState(() => _selectedLensType = v),
              validator: (v) => v == null ? 'Required' : null,
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _companyCtrl,
              decoration: const InputDecoration(labelText: 'Company'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _productCtrl,
              decoration: const InputDecoration(labelText: 'Product Name'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _productCodeCtrl,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(labelText: 'Product Code'),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Product code required' : null,
            ),

            TextFormField(
              controller: _minIndexCtrl,
              decoration: const InputDecoration(labelText: 'Min Index'),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (v) =>
                  v == null || double.tryParse(v) == null ? 'Invalid' : null,
            ),
            TextFormField(
              controller: _maxIndexCtrl,
              decoration: const InputDecoration(labelText: 'Max Index'),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (v) =>
                  v == null || double.tryParse(v) == null ? 'Invalid' : null,
            ),

            const SizedBox(height: 16),
            const Text(
              'Supported Materials',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Wrap(
              spacing: 8,
              children: LensMaterialType.values.map((material) {
                return FilterChip(
                  label: Text(material.label),
                  selected: _materials.contains(material),
                  onSelected: (v) {
                    setState(() {
                      v
                          ? _materials.add(material)
                          : _materials.remove(material);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Supported Coatings',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _coatingsCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Add coating (e.g. AR, Blue Cut)',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final value = _coatingsCtrl.text.trim();
                    if (value.isEmpty) return;

                    setState(() {
                      if (!_coatings.contains(value)) {
                        _coatings.add(value);
                      }
                      _coatingsCtrl.clear();
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              children: _coatings.map((coating) {
                return Chip(
                  label: Text(coating),
                  onDeleted: () {
                    setState(() {
                      _coatings.remove(coating);
                    });
                  },
                );
              }).toList(),
            ),
            TextFormField(
              controller: _purchasePriceCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(labelText: "Purchase price"),
              validator: (v) => v == null || double.tryParse(v) == null
                  ? 'Invalid purchase price'
                  : null,
            ),
            TextFormField(
              controller: _salesPriceCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(labelText: "Sales price"),
              validator: (v) => v == null || double.tryParse(v) == null
                  ? 'Invalid sales price'
                  : null,
            ),

            const SizedBox(height: 24),
            CustomButton(
              icon: Icons.save,
              onPressed: _isSaving ? null : () => _submit(),
              label: widget.isEdit ? 'Update Lens' : 'Save Lens',
            ),
          ],
        ),
      ),
    );
  }
}

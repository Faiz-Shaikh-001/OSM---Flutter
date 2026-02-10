import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/services/save_image_to_app_directory.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/core/widgets/custom_button.dart';
import 'package:osm/core/widgets/image_selector.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/presentation/blocs/accessory/accessory_detail/accessory_detail_bloc.dart';
import 'package:osm/features/inventory/presentation/blocs/accessory/accessory_list/accessory_list_bloc.dart';
import 'package:osm/features/inventory/presentation/dto/create_accessory_input.dart';
import 'package:uuid/uuid.dart';

class AddAccessoryFormSection extends StatefulWidget {
  final bool isEdit;
  final AccessoryId? accessoryId;
  final ValueChanged<CreateAccessoryInput> onCreate;
  final ValueChanged<Accessory> onUpdate;

  const AddAccessoryFormSection({
    super.key,
    this.isEdit = false,
    this.accessoryId,
    required this.onCreate,
    required this.onUpdate,
  });

  @override
  State<AddAccessoryFormSection> createState() =>
      _AddAccessoryFormSectionState();
}

class _AddAccessoryFormSectionState extends State<AddAccessoryFormSection> {
  final _formKey = GlobalKey<FormState>();

  final _categoryCtrl = TextEditingController();
  final _brandCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _quantityCtrl = TextEditingController();
  final _purchasePriceCtrl = TextEditingController();
  final _salesPriceCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();

  final List<File> _images = [];
  bool _isSaving = false;

  Accessory? _initialAccessory;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.accessoryId != null) {
      context.read<AccessoryDetailBloc>().add(
        GetAccessoryByIdEvent(widget.accessoryId!),
      );
    }
  }

  @override
  void dispose() {
    _categoryCtrl.dispose();
    _brandCtrl.dispose();
    _nameCtrl.dispose();
    _quantityCtrl.dispose();
    _purchasePriceCtrl.dispose();
    _salesPriceCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  void _prefill(Accessory accessory) {
    _initialAccessory = accessory;

    _categoryCtrl.text = accessory.category;
    _brandCtrl.text = accessory.brand;
    _nameCtrl.text = accessory.name;
    _quantityCtrl.text = accessory.quantity.toString();
    _purchasePriceCtrl.text = accessory.purchasePrice.value.toString();
    _salesPriceCtrl.text = accessory.salesPrice.value.toString();
    _descriptionCtrl.text = accessory.description ?? '';

    _images.addAll(accessory.imageUrls.map((p) => File(p)));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final List<String> imageUrls = [];
    for (final img in _images) {
      final path = await saveImageToAppDirectory(img);
      imageUrls.add(path);
    }

    if (widget.isEdit && _initialAccessory != null) {
      final old = _initialAccessory!;

      final updated = Accessory(
        id: old.id,
        createdAt: old.createdAt,
        category: _categoryCtrl.text.trim(),
        brand: _brandCtrl.text.trim(),
        name: _nameCtrl.text.trim(),
        sku: old.sku,
        quantity: int.parse(_quantityCtrl.text),
        purchasePrice: Money(double.parse(_purchasePriceCtrl.text)),
        salesPrice: Money(double.parse(_salesPriceCtrl.text)),
        imageUrls: imageUrls,
        isActive: old.isActive,
        description: _descriptionCtrl.text.trim().isEmpty
            ? null
            : _descriptionCtrl.text.trim(),
        qrKey: old.qrKey,
      );

      widget.onUpdate(updated);
    } else {
      final qrKey = const Uuid().v4();

      final accessory = CreateAccessoryInput(
        category: _categoryCtrl.text.trim(),
        brand: _brandCtrl.text.trim(),
        name: _nameCtrl.text.trim(),
        purchasePrice: Money(double.parse(_purchasePriceCtrl.text)),
        salesPrice: Money(double.parse(_salesPriceCtrl.text)),
        imageUrls: imageUrls,
        isActive: true,
        description: _descriptionCtrl.text.trim().isEmpty
            ? null
            : _descriptionCtrl.text.trim(),
        qrKey: qrKey,
        quantity: int.parse(_quantityCtrl.text),
      );

      widget.onCreate(accessory);
    }

    setState(() => _isSaving = false);
  }

  Widget _numberField(TextEditingController c, String label) {
    return TextFormField(
      controller: c,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      validator: (v) =>
          v == null || int.tryParse(v) == null ? 'Invalid $label' : null,
    );
  }

  Widget _priceField(TextEditingController c, String label) {
    return TextFormField(
      controller: c,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label),
      validator: (v) =>
          v == null || double.tryParse(v) == null ? 'Invalid $label' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AccessoryListBloc, AccessoryListState>(
          listener: (context, state) {
            if (state is AccessoryListActionSuccess) {
              Navigator.pop(context);
            }
            if (state is AccessoryListError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: BlocBuilder<AccessoryDetailBloc, AccessoryDetailState>(
        builder: (context, state) {
          if (widget.isEdit &&
              state is AccessoryDetailLoading &&
              _initialAccessory == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.isEdit &&
              state is AccessoryDetailLoaded &&
              _initialAccessory == null) {
            _prefill(state.accessory);
          }

          if (state is AccessoryDetailError) {
            return Center(child: Text(state.message));
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

            TextFormField(
              controller: _categoryCtrl,
              decoration: const InputDecoration(labelText: 'Category'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _brandCtrl,
              decoration: const InputDecoration(labelText: 'Brand'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Accessory Name'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _descriptionCtrl,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),

            _numberField(_quantityCtrl, 'Quantity'),
            _priceField(_purchasePriceCtrl, 'Purchase Price'),
            _priceField(_salesPriceCtrl, 'Sales Price'),

            const SizedBox(height: 24),
            CustomButton(
              icon: Icons.save,
              label: widget.isEdit ? 'Update Accessory' : 'Save Accessory',
              onPressed: _isSaving ? null : () async {_submit();},
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/utils/product_type.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/presentation/blocs/accessory/accessory_list/accessory_list_bloc.dart';
import 'package:osm/features/inventory/presentation/blocs/lens/lens_list/lens_list_bloc.dart';
import 'package:osm/features/inventory/presentation/enums/product_type_to_add.dart';
import 'package:osm/features/inventory/presentation/screens/add_stock/forms/add_accessory_form_section.dart';
import 'package:osm/features/inventory/presentation/screens/add_stock/forms/add_frame_form_section.dart';
import 'package:osm/features/inventory/presentation/screens/add_stock/forms/add_lens_form_section.dart';

class AddStockScreen extends StatefulWidget {
  final bool isEdit;
  final ProductType? productType;
  final Object? productId;

  const AddStockScreen({
    super.key,
    this.isEdit = false,
    this.productType,
    this.productId,
  });

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  ProductTypeToAdd? selectedType;

  ProductTypeToAdd? _mapProductType(ProductType? type) {
    switch (type) {
      case ProductType.frame:
        return ProductTypeToAdd.frame;
      case ProductType.lens:
        return ProductTypeToAdd.lens;
      case ProductType.accessory:
        return ProductTypeToAdd.accessory;
      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.productType != null) {
      selectedType = _mapProductType(widget.productType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEdit
            ? const Text('Edit Stock')
            : const Text('Add Stock'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _productTypeDropdown(),
            const SizedBox(height: 20),

            if (selectedType == null) const Divider(height: 32),

            if (selectedType == ProductTypeToAdd.frame)
              AddFrameFormSection(
                isEdit: widget.isEdit,
                frameId: widget.isEdit ? widget.productId as FrameId : null,
              ),

            if (selectedType == ProductTypeToAdd.lens)
              AddLensFormSection(
                isEdit: widget.isEdit,
                lensId: widget.isEdit ? widget.productId as LensId : null,
                onCreate: (input) {
                  context.read<LensListBloc>().add(CreateLensEvent(input));
                },
                onUpdate: (frame) {
                  context.read<LensListBloc>().add(UpdateLensEvent(frame));
                },
              ),

            if (selectedType == ProductTypeToAdd.accessory)
              AddAccessoryFormSection(
                isEdit: widget.isEdit,
                accessoryId: widget.isEdit
                    ? widget.productId as AccessoryId
                    : null,
                onCreate: (input) {
                  context.read<AccessoryListBloc>().add(
                    CreateAccessoryEvent(input),
                  );
                },
                onUpdate: (accessory) {
                  context.read<AccessoryListBloc>().add(
                    UpdateAccessoryEvent(accessory),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _productTypeDropdown() {
    return DropdownButtonFormField<ProductTypeToAdd>(
      initialValue: selectedType,
      decoration: const InputDecoration(
        labelText: "Select Product Type",
        border: OutlineInputBorder(),
      ),
      items: ProductTypeToAdd.values
          .map((type) => DropdownMenuItem(value: type, child: Text(type.label)))
          .toList(),
      onChanged: widget.isEdit
          ? null
          : (value) {
              setState(() => selectedType = value);
            },
    );
  }
}

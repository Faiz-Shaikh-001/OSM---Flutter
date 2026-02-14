import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens_type.dart';
import 'package:osm/features/orders/domain/entities/order_item.dart';
import 'package:osm/features/orders/presentation/blocs/order_draft/order_draft_bloc.dart';
import 'package:osm/features/orders/presentation/value_objects/product_search_result.dart';

class LensConfigSheet extends StatefulWidget {
  final ProductSearchResult lens;
  const LensConfigSheet({super.key, required this.lens});

  @override
  State<LensConfigSheet> createState() => _LensConfigSheetState();
}

class _LensConfigSheetState extends State<LensConfigSheet> {
  LensMaterialType? _selectedMaterial;
  final TextEditingController _materialPriceController = TextEditingController(
    text: "0",
  );

  // Track selected coatings and their custom prices
  final Map<String, double> _selectedCoatingsWithPrices = {};
  final TextEditingController _coatingPriceController = TextEditingController(
    text: "0",
  );

  @override
  void dispose() {
    _materialPriceController.dispose();
    _coatingPriceController.dispose();
    super.dispose();
  }

  double get _totalPrice {
    double base = widget.lens.price.value;
    double materialAdd = double.tryParse(_materialPriceController.text) ?? 0;
    double coatingAdd = _selectedCoatingsWithPrices.values.fold(
      0,
      (sum, p) => sum + p,
    );
    return base + materialAdd + coatingAdd;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDraftBloc, OrderDraftState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.lens.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Divider(),

              const Text(
                "Material & Surcharge",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButton<LensMaterialType>(
                      isExpanded: true,
                      value: _selectedMaterial,
                      hint: const Text("Select Material"),
                      items: (widget.lens.raw as Lens).supportedMaterials
                          .map(
                            (m) => DropdownMenuItem(
                              value: m,
                              child: Text(m.name.toUpperCase()),
                            ),
                          )
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _selectedMaterial = val),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _materialPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Price ₹",
                        prefixText: "₹",
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                "Add Coating",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8,
                children: (widget.lens.raw as Lens).supportedCoatings.map((
                  coating,
                ) {
                  final isSelected = _selectedCoatingsWithPrices.containsKey(
                    coating,
                  );
                  return FilterChip(
                    label: Text(coating),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        _showCoatingPriceDialog(coating);
                      } else {
                        setState(
                          () => _selectedCoatingsWithPrices.remove(coating),
                        );
                      }
                    },
                  );
                }).toList(),
              ),

              const Divider(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Base: ₹${widget.lens.price.value}"),
                      Text(
                        "Total: ₹${_totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _selectedMaterial == null ? null : _onConfirm,
                    child: const Text("Add to Order"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCoatingPriceDialog(String coating) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Price for $coating"),
        content: TextField(
          controller: _coatingPriceController,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Enter surcharge amount"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedCoatingsWithPrices[coating] =
                    double.tryParse(_coatingPriceController.text) ?? 0;
              });
              _coatingPriceController.text = "0";
              Navigator.pop(ctx);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _onConfirm() {
    final orderItem = OrderItem(
      productID: widget.lens.id,
      productName: widget.lens.name,
      productCode: widget.lens.code,
      type: widget.lens.type.toOrderItemType(),
      quantity: 1,
      basePrice: widget.lens.price,
      materialSurcharge: double.tryParse(_materialPriceController.text) ?? 0,
      coatingSurcharges: _selectedCoatingsWithPrices.values.fold(
        0,
        (sum, p) => sum + p,
      ),
      unitPrice: Money(_totalPrice),
      materialType: _selectedMaterial,
      coatings: _selectedCoatingsWithPrices.keys.toList(),
    );

    context.read<OrderDraftBloc>().add(ItemAdded(orderItem));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}

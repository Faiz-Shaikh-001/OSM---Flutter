import 'dart:io';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

import 'package:osm/core/utils/product_type.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/core/widgets/custom_button.dart';
import 'package:osm/core/widgets/qr_generator.dart';

import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame_type.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame_variant.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens_type.dart';

import 'package:osm/features/inventory/presentation/blocs/accessory/accessory_detail/accessory_detail_bloc.dart';
import 'package:osm/features/inventory/presentation/blocs/frames/frame_detail/frame_detail_bloc.dart';
import 'package:osm/features/inventory/presentation/blocs/lens/lens_detail/lens_detail_bloc.dart';

class ItemScreen extends StatefulWidget {
  final ProductType productType;
  final Id productId;

  const ItemScreen({
    super.key,
    required this.productType,
    required this.productId,
  });

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  Object? _product;
  FrameVariant? _selectedVariant;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    switch (widget.productType) {
      case ProductType.frame:
        context.read<FrameDetailBloc>().add(
          GetFrameByIdEvent(FrameId(widget.productId.toString())),
        );
        break;
      case ProductType.lens:
        context.read<LensDetailBloc>().add(
          GetLensByIdEvent(LensId(widget.productId.toString())),
        );
        break;
      case ProductType.accessory:
        context.read<AccessoryDetailBloc>().add(
          GetAccessoryByIdEvent(AccessoryId(widget.productId.toString())),
        );
        break;
    }
  }

  @override
  void dispose() {
    _selectedVariant = null;
    _product = null;
    _pageController.dispose();
    super.dispose();
  }

  void _initVariant(Frame frame) {
    if (_selectedVariant == null ||
        !frame.variants.contains(_selectedVariant)) {
      _selectedVariant = frame.variants.first;
    }
  }

  List<String> _images() {
    if (_product is Frame) return _selectedVariant?.imageUrls ?? [];
    if (_product is Lens) return (_product as Lens).imageUrls;
    if (_product is Accessory) return (_product as Accessory).imageUrls;
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Item Details')),
      body: SafeArea(child: _buildBloc()),
    );
  }

  Widget _buildBloc() {
    switch (widget.productType) {
      case ProductType.frame:
        return BlocBuilder<FrameDetailBloc, FrameDetailState>(
          builder: _handleState,
        );
      case ProductType.lens:
        return BlocBuilder<LensDetailBloc, LensDetailState>(
          builder: _handleState,
        );
      case ProductType.accessory:
        return BlocBuilder<AccessoryDetailBloc, AccessoryDetailState>(
          builder: _handleState,
        );
    }
  }

  Widget _handleState(BuildContext context, dynamic state) {
    if (state is FrameDetailLoading ||
        state is LensDetailLoading ||
        state is AccessoryDetailLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is FrameDetailLoaded) {
      _product = state.frame;
      _initVariant(state.frame);
    } else if (state is LensDetailLoaded) {
      _product = state.lens;
    } else if (state is AccessoryDetailLoaded) {
      _product = state.accessory;
    }

    if (_product == null) {
      return const Center(child: Text('Product not found'));
    }

    return _buildContent();
  }

  Widget _buildContent() {
    final images = _images();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageCarousel(images),
          if (_product is Frame) ..._buildFrameDetails(),
          if (_product is Lens) ..._buildLensDetails(),
          if (_product is Accessory) ..._buildAccessoryDetails(),
        ],
      ),
    );
  }

  List<Widget> _buildFrameDetails() {
    final frame = _product as Frame;
    return [
      _variantSelector(),
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        frame.companyName.capitalize,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        frame.name.capitalize,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '₹${_selectedVariant?.salesPrice.value.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SKU: ${_selectedVariant?.sku}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Product Code: ${_selectedVariant?.productCode}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Stock: ${_selectedVariant?.quantity}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Frame Type',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          frame.type.label,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _selectedVariant != null
                            ? Text(
                                'Color',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            : const SizedBox.shrink(),

                        _selectedVariant != null
                            ? Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Color(
                                        int.parse(
                                          '0xFF${_selectedVariant!.colorValue!.toRadixString(16).padLeft(6, '0')}',
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    _selectedVariant!.colorName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            : const Text(
                                'No variant selected',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _selectedVariant != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Size',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                ' ${_selectedVariant!.size}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QrGeneratorWidget(
                      product: _product!,
                      productType: widget.productType,
                      selectedFrameVariant: _selectedVariant,
                    ),
                  ),
                );
              },
              label: 'View Qr Code',
              icon: Icons.qr_code,
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildLensDetails() {
    final lens = _product as Lens;

    return [
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lens.companyName.capitalize,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        lens.productName.capitalize,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '₹${lens.salesPrice.value.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SKU: ${lens.sku}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Product Code: ${lens.productCode}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Supported Materials ",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...lens.supportedMaterials.map(
                          (material) => Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Chip(label: Text(material.label)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Supported Coatings ",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (lens.supportedCoatings.isEmpty)
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'None',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ...lens.supportedCoatings.map(
                          (coating) => Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Chip(label: Text(coating.capitalize)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lens Type ",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          lens.lensType.label,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Min Index ",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          lens.minIndex.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Max Index ",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          lens.maxIndex.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QrGeneratorWidget(
                      product: _product!,
                      productType: widget.productType,
                    ),
                  ),
                );
              },
              label: 'View Qr Code',
              icon: Icons.qr_code,
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildAccessoryDetails() {
    final accessory = _product as Accessory;

    return [
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        accessory.brand,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        accessory.name,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '₹${accessory.salesPrice.value.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // category
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SKU: ${accessory.sku}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Stock: ${accessory.quantity}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    const SizedBox(width: 12),
                    Row(
                      children: [
                        Text(
                          'Description: ',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      accessory.description != null
                          ? accessory.description!
                          : 'No description available.',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QrGeneratorWidget(
                      product: _product!,
                      productType: widget.productType,
                    ),
                  ),
                );
              },
              label: 'View Qr Code',
              icon: Icons.qr_code,
            ),
          ],
        ),
      ),
    ];
  }

  Widget _imageCarousel(List<String> images) {
    return SizedBox(
      height: 320,
      child: PageView.builder(
        controller: _pageController,
        itemCount: images.length,
        itemBuilder: (_, i) =>
            Image.file(File(images[i]), fit: BoxFit.fitHeight),
      ),
    );
  }

  Widget _variantSelector() {
    final frame = _product as Frame;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: frame.variants.map((v) {
            final selected = v == _selectedVariant;
            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: ChoiceChip(
                label: Text('${v.colorName} • ${v.size}'),
                selected: selected,
                onSelected: (_) {
                  setState(() {
                    _selectedVariant = v;
                  });
                },
                selectedColor: Colors.blue.shade100,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

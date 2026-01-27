import 'dart:io';
import 'package:flutter/material.dart';
import 'package:osm/core/utils/product_type.dart';
import 'package:osm/features/inventory/domain/entities/accessory/accessory.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/entities/lens/lens.dart';

class GridCard extends StatelessWidget {
  final Object product;
  final ProductType productType;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const GridCard({
    super.key,
    required this.product,
    required this.productType,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImageSection(product: product, productType: productType),
            _DetailsSection(product: product, productType: productType),
          ],
        ),
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  final Object product;
  final ProductType productType;

  const _ImageSection({required this.product, required this.productType});

  String? _resolveImage() {
    switch (productType) {
      case ProductType.frame:
        final frame = product as Frame;
        if (frame.variants.isNotEmpty &&
            frame.variants.first.imageUrls.isNotEmpty) {
          return frame.variants.first.imageUrls.first;
        }
        break;

      case ProductType.lens:
        final lens = product as Lens;
        if (lens.imageUrls.isNotEmpty) {
          return lens.imageUrls.first;
        }
        break;

      case ProductType.accessory:
        final accessory = product as Accessory;
        if (accessory.imageUrls.isNotEmpty) {
          return accessory.imageUrls.first;
        }
        break;
    }
    return null;
  }

  String _heroTag() {
    return '${productType.name}_${(product as dynamic).id}';
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = _resolveImage();

    return Expanded(
      child: Hero(
        tag: _heroTag(),
        child: imagePath == null
            ? _placeholder()
            : Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, _, _) => _placeholder(),
              ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
      ),
    );
  }
}

class _DetailsSection extends StatelessWidget {
  final Object product;
  final ProductType productType;

  const _DetailsSection({required this.product, required this.productType});

  String get _title {
    switch (productType) {
      case ProductType.frame:
        final frame = product as Frame;
        return '${frame.companyName} ${frame.name}';

      case ProductType.lens:
        final lens = product as Lens;
        return '${lens.companyName} ${lens.productName}';

      case ProductType.accessory:
        final accessory = product as Accessory;
        return '${accessory.brand} ${accessory.name}';
    }
  }

  double get _price {
    switch (productType) {
      case ProductType.frame:
        final frame = product as Frame;
        return frame.variants.isNotEmpty
            ? frame.variants.first.salesPrice.value
            : 0;

      case ProductType.lens:
        final lens = product as Lens;
        return lens
            .salesPrice
            .value;

      case ProductType.accessory:
        final accessory = product as Accessory;
        return accessory.salesPrice.value;
    }
  }

  int get _quantity {
    switch (productType) {
      case ProductType.frame:
        final frame = product as Frame;
        return frame.variants.isNotEmpty ? frame.variants.first.quantity : 0;

      case ProductType.lens:
        return 0;

      case ProductType.accessory:
        final accessory = product as Accessory;
        return accessory.quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${_price.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                'Qty: $_quantity',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

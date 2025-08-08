import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:osm/data/models/frame_model.dart';
import 'package:osm/data/models/lens_model.dart';
import 'package:osm/screens/item_screen.dart';
import 'package:osm/utils/product_type.dart';

class GridCard extends StatelessWidget {
  final dynamic product;
  final ProductType productType;
  final int heroIndex;
  final bool isLowStock;

  const GridCard({
    super.key,
    required this.heroIndex,
    required this.product,
    required this.productType,
    this.isLowStock = false,
  });

  final double _borderRadius = 15.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      // padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          try {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemPage(
                  product: product,
                  productType: productType,
                  heroIndex: heroIndex,
                ),
              ),
            );
          } catch (e, stack) {
            debugPrint("Error during navigation: $e");
            debugPrint("$stack");
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BuildImageSection(
              product: product,
              productType: productType,
              heroIndex: heroIndex,
            ),
            const SizedBox(height: 4),
            _BuildDetailsSection(
              product: product,
              productType: productType,
              isLowStock: isLowStock,
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildImageSection extends StatelessWidget {
  final dynamic product;
  final ProductType productType;
  final int heroIndex;
  const _BuildImageSection({
    required this.product,
    required this.productType,
    required this.heroIndex,
  });

  Widget _buildImage(String imagePath) {
    if (imagePath.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imagePath,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.white,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: const Center(
            child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
          ),
        ),
      );
    } else {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey[200],
          child: const Center(
            child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
          ),
        ),
      );
    }
  }

  String _getImageUrl(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      final frame = product as FrameModel;
      return frame.variants.isNotEmpty &&
              frame.variants.first.imageUrls.isNotEmpty
          ? frame.variants.first.imageUrls.first
          : 'https://placehold.co/400x400/png?text=Frame';
    } else if (type == ProductType.lens) {
      final lens = product as LensModel;
      return lens.imageUrls.isNotEmpty
          ? lens.imageUrls.first
          : 'https://placehold.co/400x400/png?text=Product';
    }
    return 'https://placehold.co/400x400/png?text=Product';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Image change
      child: Hero(
        tag: 'itemImage_${product.id ?? 'noid'}_$heroIndex',
        child: SizedBox(
          width: double.infinity,
          child: _buildImage(_getImageUrl(product, productType)),
        ),

        // CachedNetworkImage(
        //   imageUrl: _getImageUrl(product, productType),
        //   fit: BoxFit.cover,
        //   width: double.infinity,
        //   placeholder: (context, url) => Container(
        //     color: Colors.white,
        //     child: const Center(
        //       child: CircularProgressIndicator(strokeWidth: 2),
        //     ),
        //   ),
        //   errorWidget: (context, url, error) => Container(
        //     color: Colors.grey[200],
        //     child: const Center(
        //       child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

class _BuildDetailsSection extends StatelessWidget {
  final dynamic product;
  final ProductType productType;
  final bool isLowStock;

  const _BuildDetailsSection({
    required this.product,
    required this.productType,
    required this.isLowStock,
  });

  String _getTitle(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      return '${(product as FrameModel).companyName} ${product.name}';
    } else if (type == ProductType.lens) {
      return '${(product as LensModel).companyName} ${product.productName}';
    }
    return 'Unknown Product';
  }

  String _getCompanyName(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      return (product as FrameModel).companyName;
    } else if (type == ProductType.lens) {
      return (product as LensModel).companyName;
    }
    return 'N/A';
  }

  bool _isLowStock(dynamic product, ProductType type) {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BuildTitleAndBadge(
              title: _getTitle(product, productType),
              isLowStock: isLowStock,
            ),
            const SizedBox(height: 4),
            Text(
              _getCompanyName(product, productType),
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 4),
            _BuildPriceAndStock(product: product, productType: productType),
          ],
        ),
      ),
    );
  }
}

class _BuildTitleAndBadge extends StatelessWidget {
  final String title;
  final bool isLowStock;

  const _BuildTitleAndBadge({required this.title, required this.isLowStock});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        if (isLowStock)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Text(
              'Low Stock',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
      ],
    );
  }
}

class _BuildPriceAndStock extends StatelessWidget {
  final dynamic product;
  final ProductType productType;

  const _BuildPriceAndStock({required this.product, required this.productType});

  double _getProductPrice(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      final frame = product as FrameModel;
      return frame.variants.isNotEmpty
          ? frame.variants.first.salesPrice ?? 0.0
          : 0.0;
    } else if (type == ProductType.lens) {
      final lens = product as LensModel;
      return lens.variants.isNotEmpty
          ? lens.variants.first.salesPrice ?? 0.0
          : 0.0;
    }
    return 0.0;
  }

  int _getProductQuantity(dynamic product, ProductType type) {
    if (type == ProductType.frame) {
      final frame = product as FrameModel;
      return frame.variants.isNotEmpty ? frame.variants.first.quantity ?? 0 : 0;
    } else if (type == ProductType.lens) {
      final lens = product as LensModel;
      return lens.variants.isNotEmpty ? lens.variants.first.quantity ?? 0 : 0;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '₹${_getProductPrice(product, productType).toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          'Qty: ${_getProductQuantity(product, productType)}',
          style: TextStyle(color: Colors.grey[700]),
        ),
      ],
    );
  }
}

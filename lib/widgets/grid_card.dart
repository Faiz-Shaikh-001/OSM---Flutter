import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  final int index;
  final VoidCallback onTap;

  const GridCard({super.key, required this.index, required this.onTap});

  final double _borderRadius = 15.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_borderRadius),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BuildImageSection(index: index),
              const SizedBox(height: 4),
              _BuildDetailsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildImageSection extends StatelessWidget {
  const _BuildImageSection({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Image change
      child: Hero(
        tag: 'itemImage_$index',
        child: CachedNetworkImage(
          imageUrl: "https://picsum.dev/image/$index/400/400",
          fit: BoxFit.cover,
          width: double.infinity,
          placeholder: (context, url) => Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
        ),
      ),
    );
  }
}

class _BuildDetailsSection extends StatelessWidget {
  const _BuildDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BuildTitleAndBadge(),
            const SizedBox(height: 4),
            Text('Company name'),
            const SizedBox(height: 4),
            _BuildPriceAndStock(),
          ],
        ),
      ),
    );
  }
}

class _BuildTitleAndBadge extends StatelessWidget {
  const _BuildTitleAndBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Title', style: TextStyle(fontWeight: FontWeight.bold)),
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
  const _BuildPriceAndStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('\$99.99', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('Qty: 99'),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class StoreSelectorTile extends StatelessWidget {
  final String storeName;
  final VoidCallback? onTap;

  const StoreSelectorTile({
    super.key,
    required this.storeName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.storefront_outlined),
      title: Text(
        storeName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(Icons.swap_horiz),
      onTap: onTap ?? () {},
    );
  }
}
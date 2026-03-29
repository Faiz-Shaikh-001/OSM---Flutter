import 'package:flutter/material.dart';

class StoreSelectorTile extends StatelessWidget {
  final String storeName;
  final VoidCallback onTap;

  const StoreSelectorTile({
    super.key,
    required this.storeName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.store_outlined),
      title: const Text(
        'Active Store',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(storeName),
      trailing: const Icon(Icons.keyboard_arrow_down),
      onTap: onTap,
    );
  }
}
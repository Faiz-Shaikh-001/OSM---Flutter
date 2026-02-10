import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onScan;
  final VoidCallback onSearch;

  const ActionButtons({
    super.key,
    required this.onScan,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.qr_code_scanner),
          label: const Text('Scan Product'),
          onPressed: onScan,
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.search),
          label: const Text('Search'),
          onPressed: onSearch,
        ),
      ],
    );
  }
}

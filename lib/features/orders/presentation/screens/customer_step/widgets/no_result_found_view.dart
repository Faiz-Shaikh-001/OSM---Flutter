import 'package:flutter/material.dart';

class NoResultsFoundView extends StatelessWidget {
  final VoidCallback onAddNew;

  const NoResultsFoundView({super.key, required this.onAddNew});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_search, size: 50, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No customers found.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          FilledButton.tonal(
            onPressed: onAddNew,
            child: const Text('Add New Customer'),
          ),
        ],
      ),
    );
  }
}

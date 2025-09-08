import 'package:flutter/material.dart';

class EmptyCustomerPlaceholder extends StatelessWidget {
  const EmptyCustomerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No customers found. Add some!'));
  }
}

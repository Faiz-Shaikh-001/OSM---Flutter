import 'package:flutter/material.dart';

class DefaultDiscountRateScreen extends StatelessWidget {
  const DefaultDiscountRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Default Discount Rate')),
      body: const Center(
        child: Text(
          'Discount configuration coming soon',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

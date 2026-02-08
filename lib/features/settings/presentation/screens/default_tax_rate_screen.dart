import 'package:flutter/material.dart';

class DefaultTaxRateScreen extends StatelessWidget {
  const DefaultTaxRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Default Tax Rate (GST)')),
      body: const Center(
        child: Text(
          'Tax Rate configuration coming soon',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

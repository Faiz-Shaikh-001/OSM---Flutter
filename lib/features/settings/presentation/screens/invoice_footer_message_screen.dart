import 'package:flutter/material.dart';

class InvoiceFooterMessageScreen extends StatelessWidget {
  const InvoiceFooterMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invoice Footer Message')),
      body: const Center(
        child: Text(
          'Footer message configuration coming soon',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

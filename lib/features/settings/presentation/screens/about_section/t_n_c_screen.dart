import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terms & Conditions')),
      body: Center(
        child: Text(
          'Terms & Conditions content goes here',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Policy')),
      body: Center(
        child: Text(
          'Privacy Policy content goes here',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

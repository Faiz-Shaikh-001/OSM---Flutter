import 'package:flutter/material.dart';

class InitialPromptView extends StatelessWidget {
  const InitialPromptView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Search for a customer to begin.',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}

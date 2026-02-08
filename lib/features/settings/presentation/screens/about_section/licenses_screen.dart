import 'package:flutter/material.dart';

class LicensesScreen extends StatelessWidget {
  const LicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LicensePage(
      applicationName: 'OSM',
      applicationVersion: '1.0.0',
    );
  }
}

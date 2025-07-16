import 'package:flutter/material.dart';
import '../pages/inventory_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Optics Store Management',
      home: DefaultTabController(length: 2, child: InventoryPage()),
    );
  }
}

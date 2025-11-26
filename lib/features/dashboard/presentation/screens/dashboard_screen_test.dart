import 'dart:math';
import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:osm/features/customer/data/customer_repository.dart';
import 'package:osm/features/customer/presentation/screens/customer_list_screen.dart';
import 'package:osm/features/dashboard/presentation/screens/dashboard_body.dart';
import 'package:osm/features/inventory/data/repositories/frame_repository.dart';
import 'package:osm/features/inventory/data/repositories/lens_repository.dart';
import 'package:osm/features/inventory/presentation/screens/inventory_screen.dart';
import 'package:osm/features/orders/data/repositories/order_repository.dart';
import 'package:osm/features/orders/presentation/screens/add_order_screen.dart';
import 'package:osm/features/orders/presentation/screens/order_list_screen.dart';
import 'package:osm/features/settings/presentation/screens/settings_screen.dart';
import 'package:provider/provider.dart';


class DashboardScreenTest extends StatefulWidget {
  const DashboardScreenTest({super.key});

  @override
  State<DashboardScreenTest> createState() => _DashboardScreenTestState();
}

class _DashboardScreenTestState extends State<DashboardScreenTest> {
  int _selectedIndex = 2;
  bool _isDialOpen = false;

  final List<Widget> _pages = [
    const OrderListScreen(),
    const InventoryScreen(),
    const SizedBox(),
    const CustomerListScreen(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 2
          ? AppBar(
              title: const Text(
                "Dashboard",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Notifications pressed")),
                    );
                  },
                ),
              ],
            )
          : null,
      body: Stack(
        children: [
          _selectedIndex == 2
              ? BuildDashboardBody(
                  frameRepository: context.read<FrameRepository>(),
                  lensRepository: context.read<LensRepository>(),
                  customerRepository: context.read<CustomerRepository>(),
                  orderRepository: context.read<OrderRepository>(),
                )
              : _pages[_selectedIndex],
          if (_isDialOpen && _selectedIndex == 2) _buildBlurOverlay(),
          if (_isDialOpen && _selectedIndex == 2) ..._buildFloatingActions(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _selectedIndex == 2
          ? _buildFloatingActionButtons()
          : null,
    );
  }

  Widget _buildBottomNavigationBar() {
    return CurvedNavigationBar(
      index: _selectedIndex,
      height: 55,
      backgroundColor: Colors.transparent,
      color: Colors.blueAccent,
      buttonBackgroundColor: Colors.blueAccent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      items: const [
        Icon(Icons.receipt_long, size: 30, color: Colors.white),
        Icon(Icons.store, size: 30, color: Colors.white),
        Icon(Icons.dashboard, size: 30, color: Colors.white),
        Icon(Icons.people_alt, size: 30, color: Colors.white),
        Icon(Icons.settings, size: 30, color: Colors.white),
      ],
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          _isDialOpen = false;
        });
      },
    );
  }

  Widget _buildBlurOverlay({double blurSigma = 4.0, double opacity = 0.5}) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () => setState(() => _isDialOpen = false),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: 1.0,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Container(color: Color.fromRGBO(0, 0, 0, opacity)),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButtons() {
    return FloatingActionButton(
      onPressed: () => setState(() => _isDialOpen = !_isDialOpen),
      backgroundColor: _isDialOpen ? Colors.transparent : Colors.blueAccent,
      elevation: _isDialOpen ? 0 : 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: _isDialOpen
            ? const BorderSide(color: Colors.red, width: 2)
            : BorderSide.none,
      ),
      child: Icon(
        _isDialOpen ? Icons.close : Icons.add,
        color: _isDialOpen ? Colors.red : Colors.white,
      ),
    );
  }

  List<Widget> _buildFloatingActions() {
    final double radius = 100;
    final Offset center = const Offset(20, 20);

    final actions = [
      {
        'tooltip': 'Create Order',
        'icon': Icons.edit_note,
        'color': Colors.blue,
        'angle': 90.0,
      },
      {
        'tooltip': 'Scan Barcode',
        'icon': Icons.barcode_reader,
        'color': Colors.green,
        'angle': 45.0,
      },
      {
        'tooltip': 'Manage Stock',
        'icon': Icons.store,
        'color': Colors.deepPurple,
        'angle': 0.0,
      },
    ];

    return actions.map((action) {
      final double angle = action['angle'] as double;
      final double rad = angle * (pi / 180.0);
      final double dx = radius * cos(rad);
      final double dy = radius * sin(rad);

      return Positioned(
        bottom: center.dy + dy,
        right: center.dx + dx,
        child: Tooltip(
          message: action['tooltip'] as String,
          child: FloatingActionButton(
            heroTag: action['tooltip'],
            mini: true,
            backgroundColor: Colors.white,
            onPressed: () => _handleAction(action['tooltip'] as String),
            child: Icon(
              action['icon'] as IconData,
              color: action['color'] as Color,
              size: 30,
            ),
          ),
        ),
      );
    }).toList();
  }

  void _handleAction(String label) {
    setState(() => _isDialOpen = false);
    if (label == 'Create Order') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddOrderScreen()),
      );
    } else if (label == 'Scan Barcode') {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$label tapped')));
    } else if (label == 'Manage Stock') {
      // Navigate to InventoryScreen
      setState(() {
        _selectedIndex = 1; // Index for InventoryScreen
      });
    }
  }
}
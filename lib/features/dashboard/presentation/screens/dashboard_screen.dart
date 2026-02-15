import 'dart:math';
import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:osm/features/customer/presentation/screens/customer_list_screen.dart';
import 'package:osm/features/dashboard/presentation/screens/dashboard_body.dart';
import 'package:osm/features/inventory/presentation/screens/inventory_screen.dart';
import 'package:osm/features/orders/presentation/screens/add_order/create_order_flow_screen.dart';
import 'package:osm/features/orders/presentation/screens/order_list/order_list_screen.dart';
import 'package:osm/features/settings/presentation/screens/settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 2;
  bool _isDialOpen = false;

  final List<Widget> _pages = [
    const OrderListScreen(),
    const InventoryScreen(),
    const SizedBox(),
    const CustomerListScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 2 ? _buildAppBar(context) : null,
      body: Stack(
        children: [
          Positioned.fill(
            child: _selectedIndex == 2
                ? BuildDashboardBody()
                : _pages[_selectedIndex],
          ),
          if (_isDialOpen && _selectedIndex == 2) _buildBlurOverlay(),
          if (_isDialOpen && _selectedIndex == 2) ..._buildFloatingActions(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _selectedIndex == 2 ? _buildMainFAB() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext content) {
    return AppBar(
      title: const Text(
        "Dashboard",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Notifications pressed")));
          },
        ),
      ],
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

  Widget _buildMainFAB() {
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

  List<Widget> _buildFloatingActions() {
    final double radius = 100;
    final Offset center = const Offset(20, 20);

    final actions = [
      _FabAction(
        label: 'Create Order',
        icon: Icons.edit_note,
        angle: 90.0,
        color: Colors.blue,
      ),
      _FabAction(
        label: 'Scan Barcode',
        icon: Icons.barcode_reader,
        angle: 45.0,
        color: Colors.green,
      ),
      _FabAction(
        label: 'Manage Stock',
        icon: Icons.store,
        angle: 0.0,
        color: Colors.deepPurple,
      ),
    ];

    return actions.map((action) {
      final double rad = action.angle * (pi / 180.0);
      final double dx = radius * cos(rad);
      final double dy = radius * sin(rad);

      return Positioned(
        bottom: center.dy + dy,
        right: center.dx + dx,
        child: Tooltip(
          message: action.label,
          child: FloatingActionButton(
            heroTag: action.label,
            mini: true,
            backgroundColor: Colors.white,
            onPressed: () => _handleAction(action.label),
            child: Icon(action.icon, color: action.color, size: 30),
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
        MaterialPageRoute(builder: (context) => const CreateOrderFlowScreen()),
      );
    } else if (label == 'Scan Barcode') {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$label tapped')));
    } else if (label == 'Manage Stock') {
      setState(() {
        _selectedIndex = 1;
      });
    }
  }
}

class _FabAction {
  final String label;
  final IconData icon;
  final double angle;
  final Color color;

  const _FabAction({
    required this.label,
    required this.icon,
    required this.angle,
    required this.color,
  });
}

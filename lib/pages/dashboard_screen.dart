import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:osm/pages/inventory_screen.dart';
import 'package:osm/pages/settings_screen.dart';
import 'dart:math';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 2;
  bool _isDialOpen = false;

  final List<Widget> _pages = [
    const Center(child: Text('Orders')),
    const InventoryScreen(),
    const SizedBox(),
    const Center(child: Text('Customers')),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 2
          ? AppBar(
              title: const Text('Dashboard'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none),
                  onPressed: () {},
                ),
              ],
            )
          : null,
      body: Stack(
        children: [
          _selectedIndex == 2
              ? _BuildDashboardContent()
              : _pages[_selectedIndex],

          if (_isDialOpen && _selectedIndex == 2) _buildBlurOverlay(),

          if (_isDialOpen && _selectedIndex == 2) ..._buildFloatingActions(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
            _isDialOpen = false;
          });
        },
        height: 70,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          NavigationDestination(icon: Icon(Icons.store), label: 'Inventory'),
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt),
            label: 'Customers',
          ),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: _selectedIndex == 2
          ? FloatingActionButton(
              onPressed: () => setState(() => _isDialOpen = !_isDialOpen),
              backgroundColor: _isDialOpen
                  ? Colors.transparent
                  : Colors.blueAccent,
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
            )
          : null,
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$label tapped')));
  }
}

// Dashboard content
class _BuildDashboardContent extends StatelessWidget {
  const _BuildDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search orders, products...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatCard(context, 'Total Orders', '156'),
            _buildStatCard(context, 'Pending Payments', '\$2,850'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatCard(context, 'Stock Alerts', '23'),
            _buildStatCard(context, 'Today\'s Sales', '\$1,203'),
          ],
        ),
        const SizedBox(height: 30),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Recent Activities',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: const [
              ListTile(
                title: Text('New Order #1234'),
                subtitle: Text('John Doe • Progressive Lenses'),
                trailing: Text('2 mins ago'),
              ),
              ListTile(
                title: Text('Payment received'),
                subtitle: Text('Order #1233 • \$350.00'),
                trailing: Text('10 mins ago'),
              ),
              ListTile(
                title: Text('Low stock alert'),
                subtitle: Text('Ray-Ban Frames - 3 items left'),
                trailing: Text('2 hours ago'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

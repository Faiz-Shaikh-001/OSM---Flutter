import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:osm/pages/inventory_page.dart';
import 'package:osm/pages/settings_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 2;
  bool _isDialOpen = false;

  final List<Widget> _pages = [
    const Center(child: Text('Orders')),     // TODO: Replace with actual OrdersPage()
    const InventoryPage(),                   // Connected properly
    const SizedBox(),                        // Placeholder for Dashboard page
    const Center(child: Text('Customers')),  // TODO: Replace with actual CustomersPage()
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
              ? _buildDashboardContent()
              : _pages[_selectedIndex],

          if (_isDialOpen && _selectedIndex == 2) _buildBlurOverlay(),

          if (_isDialOpen && _selectedIndex == 2) ..._buildFloatingActions(),
          
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60,
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
            _isDialOpen = false; // Close the dial when switching tabs
          });
        },
      ),
      floatingActionButton: _selectedIndex == 2
          ? Padding(
              padding: const EdgeInsets.only(bottom: 12, right: 8),
              child: FloatingActionButton(
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
              ),
            )
          : null,
    );
  }

  Widget _buildDashboardContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search orders, products...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard('Total Orders', '156'),
              _buildStatCard('Pending Payments', '\$2,850'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard('Stock Alerts', '23'),
              _buildStatCard('Today\'s Sales', '\$1,203'),
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
      ),
    );
  }

  Widget _buildBlurOverlay() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () => setState(() => _isDialOpen = false),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFloatingActions() {
    return [
      _buildActionFab(
        tooltip: 'Create Order',
        icon: Icons.edit_note,
        dx: 10,
        dy: 50,
        onTap: () => _handleAction('Create Order'),
        color: Colors.blue,
      ),
      _buildActionFab(
        tooltip: 'Scan Barcode',
        icon: Icons.qr_code,
        dx: 80,
        dy: 5,
        onTap: () => _handleAction('Scan Barcode'),
        color: Colors.green,
      ),
      _buildActionFab(
        tooltip: 'Manage Stock',
        icon: Icons.store,
        dx: 100,
        dy: -70,
        onTap: () => _handleAction('Manage Stock'),
        color: Colors.deepPurple,
      ),
    ];
  }

  Widget _buildActionFab({
    required String tooltip,
    required IconData icon,
    required double dx,
    required double dy,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Positioned(
      bottom: 80 + dy,
      right: 20 + dx,
      child: Tooltip(
        message: tooltip,
        child: FloatingActionButton(
          heroTag: tooltip,
          mini: true,
          backgroundColor: Colors.transparent,
          onPressed: onTap,
          child: Icon(icon, color: color),
        ),
      ),
    );
  }

  void _handleAction(String label) {
    setState(() => _isDialOpen = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label tapped')),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

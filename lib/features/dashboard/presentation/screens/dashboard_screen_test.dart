import 'dart:math';
import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osm/core/utils/product_type.dart';
import 'package:osm/features/customer/data/customer_model.dart';
import 'package:osm/features/customer/data/customer_repository.dart';
import 'package:osm/features/customer/presentation/screens/customer_details_screen.dart';
import 'package:osm/features/customer/presentation/screens/customer_list_screen.dart';
import 'package:osm/features/dashboard/presentation/screens/lowStockItemsScreen.dart';
import 'package:osm/features/dashboard/presentation/widgets/global_search_delegate.dart';
import 'package:osm/features/dashboard/presentation/widgets/historyGraph/bar_graph.dart';
import 'package:osm/features/dashboard/presentation/widgets/summary_chip.dart';
import 'package:osm/features/inventory/data/models/frame_model.dart';
import 'package:osm/features/inventory/data/models/lens_model.dart';
import 'package:osm/features/inventory/data/repositories/frame_repository.dart';
import 'package:osm/features/inventory/data/repositories/inventory_repository.dart';
import 'package:osm/features/inventory/data/repositories/lens_repository.dart';
import 'package:osm/features/inventory/presentation/screens/inventory_screen.dart';
import 'package:osm/features/inventory/presentation/screens/item_screen.dart';
import 'package:osm/features/orders/data/models/order_model.dart';
import 'package:osm/features/orders/data/repositories/order_repository.dart';
import 'package:osm/features/orders/presentation/screens/add_order_screen.dart';
import 'package:osm/features/orders/presentation/screens/order_detail_screen/order_detail_screen.dart';
import 'package:osm/features/orders/presentation/screens/order_list_screen.dart';
import 'package:osm/features/settings/presentation/screens/settings_screen.dart';
import 'package:provider/provider.dart';

const double svgIconHeight = 30;
const double svgIconWidth = 70;

const String orderAsset = 'assets/icons/order.svg';
const String lowStockAsset = 'assets/icons/low-stock.svg';
const String pendingOrderAsset = 'assets/icons/pending-order.svg';
const String totalEarningAsset = 'assets/icons/total-earning.svg';

final Widget orderSvg = SvgPicture.asset(
  orderAsset,
  semanticsLabel: "Order Icon",
  width: svgIconWidth,
  height: svgIconHeight,
  color: Colors.blue[800],
);
final Widget lowStockSvg = SvgPicture.asset(
  lowStockAsset,
  semanticsLabel: "Low Stock Icon",
  width: svgIconWidth,
  height: svgIconHeight,
  color: Colors.red[800],
);
final Widget pendingOrderSvg = SvgPicture.asset(
  pendingOrderAsset,
  semanticsLabel: "Pending Order Icon",
  width: svgIconWidth,
  height: svgIconHeight,
  color: Colors.yellow[800],
);
final Widget totalEarningSvg = SvgPicture.asset(
  totalEarningAsset,
  semanticsLabel: "Total Earning Icon",
  width: svgIconWidth,
  height: svgIconHeight,
  color: Colors.green[800],
);

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
          _selectedIndex == 2 ? BuildDashboardBody(
            frameRepository: context.read<FrameRepository>(),
            lensRepository: context.read<LensRepository>(),
            customerRepository: context.read<CustomerRepository>(),
            orderRepository: context.read<OrderRepository>(),
          ) : _pages[_selectedIndex],
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

class BuildDashboardBody extends StatefulWidget {
  final FrameRepository frameRepository;
  final LensRepository lensRepository;
  final CustomerRepository customerRepository;
  final OrderRepository orderRepository;

  const BuildDashboardBody({
    super.key,
    required this.frameRepository,
    required this.lensRepository,
    required this.customerRepository,
    required this.orderRepository,
  });

  @override
  State<BuildDashboardBody> createState() => _BuildDashboardBodyState();
}

class _BuildDashboardBodyState extends State<BuildDashboardBody> {
  final TextEditingController _globalSearchController = TextEditingController();

  @override
  void dispose() {
    _globalSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * .90,
                  child: _buildGlobalSearchDelegate(
                    context,
                    _globalSearchController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            _buildSummaryChips(),
            SizedBox(height: 30),
            _buildHistoryBarGraph(),
            SizedBox(height: 30),
            _buildRecentActivities(),
          ],
        ),
      ),
    );
  }

  Widget _buildGlobalSearchDelegate(
    BuildContext context,
    TextEditingController controller,
  ) {
    return GestureDetector(
      onTap: () async {
        final result = await showSearch(
          context: context,
          delegate: GlobalSearchDelegate(
            widget.lensRepository,
            widget.frameRepository,
            widget.orderRepository,
            widget.customerRepository,
          ),
        );
        if (result != null) {
          if (result is OrderModel) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return OrderDetailsScreen(order: result);
                },
              ),
            );
          } else if (result is FrameModel) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return ItemPage(
                    product: result,
                    productType: ProductType.frame,
                  );
                },
              ),
            );
          } else if (result is LensModel) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return ItemPage(
                    product: result,
                    productType: ProductType.lens,
                  );
                },
              ),
            );
          } else if (result is CustomerModel) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return CustomerDetailsScreen(customer: result);
                },
              ),
            );
          }
        }
      },
      child: AbsorbPointer(
        child: TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Search Orders, Customer, Product,...',
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
          onChanged: (text) {
            print('Text changed: $text');
          },
          obscureText: false, // Set to true for password fields
        ),
      ),
    );
  }

  Widget _buildSummaryChips() {
    final totalOrders = context.watch<OrderRepository>().totalOrders;
    final todaysSale = context.watch<OrderRepository>().todaysSale;
    final pendingPayments = context.watch<OrderRepository>().pendingPayments;
    final lowStockCount = context.watch<InventoryRepository>().lowStockCount;


    return SizedBox(
      width: MediaQuery.of(context).size.width * .90,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SummaryChip(
                color: Colors.blue[100],
                svg: orderSvg,
                title: "Total Orders",
                content: totalOrders.toString(),
              ),
              SummaryChip(
                color: Colors.green[100],
                svg: totalEarningSvg,
                title: "Today's Sale",
                content: "₹${todaysSale.toStringAsFixed(0)}",
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SummaryChip(
                color: Colors.yellow[100],
                svg: pendingOrderSvg,
                title: "Pending Payments",
                content: "₹${pendingPayments.toStringAsFixed(0)}",
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const LowStockItemsScreen()));
                },
                child: SummaryChip(
                  color: Colors.red[100],
                  svg: lowStockSvg,
                  title: "Low Stock",
                  content: lowStockCount.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryBarGraph() {
    // List of weekly income
    List<double> weeklySummary = [
      4.40,
      9.30,
      43.03,
      234.53,
      100.20,
      39.21,
      23.21,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Weekly Report",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 200,
          child: HistoryBarGraph(weeklySummary: weeklySummary),
        ),
      ],
    );
  }

  Widget _buildRecentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            'Recent Activities',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 10),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            InkWell(
              onTap: () {
                debugPrint('Tapped on New Order #1234');
                // You can add navigation or custom logic here
              },
              child: ListTile(
                title: Text('New Order #1234'),
                subtitle: Text('John Doe • Progressive Lenses'),
                trailing: Text('2 mins ago'),
              ),
            ),
            InkWell(
              onTap: () {
                debugPrint('Tapped on Payment received');
              },
              child: ListTile(
                title: Text('Payment received'),
                subtitle: Text('Order #1233 • \$350.00'),
                trailing: Text('10 mins ago'),
              ),
            ),
            InkWell(
              onTap: () {
                debugPrint('Tapped on Low stock alert');
              },
              child: ListTile(
                title: Text('Low stock alert'),
                subtitle: Text('Ray-Ban Frames - 3 items left'),
                trailing: Text('2 hours ago'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

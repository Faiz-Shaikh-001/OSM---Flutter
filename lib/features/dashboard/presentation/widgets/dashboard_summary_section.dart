import 'package:flutter/material.dart';
import 'package:osm/core/constants/app_assets.dart';
import 'package:osm/features/dashboard/presentation/screens/lowStockItemsScreen.dart';
import 'package:osm/features/dashboard/presentation/widgets/summary_chip.dart';
import 'package:osm/features/inventory/data/repositories/inventory_repository.dart';
import 'package:osm/features/orders/data/repositories/order_repository.dart';
import 'package:provider/provider.dart';

class DashboardSummarySection extends StatelessWidget {
  const DashboardSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final totalOrders = context.select((OrderRepository o) => o.totalOrders);
    final todaysSale = context.select((OrderRepository o) => o.todaysSale);
    final pendingPayments = context.select((OrderRepository o) => o.todaysSale);
    final lowStockCount = context.select((InventoryRepository i) => i.lowStockCount);

    return SizedBox(
      width: MediaQuery.of(context).size.width * .90,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SummaryChip(
                color: Colors.blue[100],
                svg: AppIcons.order(),
                title: "Total Orders",
                content: totalOrders.toString(),
              ),
              SummaryChip(
                color: Colors.green[100],
                svg: AppIcons.totalEarning(),
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
                svg: AppIcons.pendingOrder(),
                title: "Pending Payments",
                content: "₹${pendingPayments.toStringAsFixed(0)}",
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LowStockItemsScreen(),
                    ),
                  );
                },
                child: SummaryChip(
                  color: Colors.red[100],
                  svg: AppIcons.lowStock(),
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
}

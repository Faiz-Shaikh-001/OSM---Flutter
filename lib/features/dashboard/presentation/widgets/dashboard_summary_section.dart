import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/constants/app_assets.dart';
import 'package:osm/features/dashboard/presentation/blocs/dashboard/dashboard_bloc.dart';
import 'package:osm/features/dashboard/presentation/screens/low_stock_items_screen.dart';
import 'package:osm/features/dashboard/presentation/widgets/summary_chip.dart';

class DashboardSummarySection extends StatelessWidget {
  const DashboardSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final isLoading = state.status == DashboardStatus.loading;

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
                    content: isLoading
                        ? "..."
                        : state.activeOrdersCount.toString(),
                  ),
                  SummaryChip(
                    color: Colors.green[100],
                    svg: AppIcons.totalEarning(),
                    title: "Today's Sale",
                    content: isLoading
                        ? "..."
                        : "₹${state.dailySales.toStringAsFixed(0)}",
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
                    content: isLoading ? "..." : "₹${state.pendingPayments.toStringAsFixed(0)}",
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
                      content: isLoading ? "..." : state.lowStockCount.toString(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

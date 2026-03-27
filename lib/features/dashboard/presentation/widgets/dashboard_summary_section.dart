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
    // BlocBuilder handles the subscription to the DashboardBloc
    // Every time emit() is called in the Bloc, this builder re-runs.

    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        debugPrint(
          "Current UI State: ${state.status} - Count: ${state.activeOrderCount}",
        );
        // Boolean flag to show placeholders if the data is still fetching
        final isLoading = state.status == DashboardStatus.loading;

        return SizedBox(
          // Responsive width: taking upto 90% of the screen width
          width: MediaQuery.of(context).size.width * .90,
          child: Column(
            children: [
              // First Row: High-level metrics (Orders and Sales)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SummaryChip(
                    color: Colors.blue[100],
                    svg: AppIcons.order(),
                    title: "Total Active Orders",
                    content: isLoading
                        ? "..."
                        : state.activeOrderCount.toString(),
                  ),
                  SummaryChip(
                    color: Colors.green[100],
                    svg: AppIcons.totalEarning(),
                    title: "Today's Sale",
                    content: isLoading
                        ? "..."
                        : "₹${state.dailySales.toString()}",
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Second Row: Operational alerts (Payments and Inventory)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SummaryChip(
                    color: Colors.yellow[100],
                    svg: AppIcons.pendingOrder(),
                    title: "Pending Payments",
                    content: isLoading
                        ? "..."
                        : "₹${state.pendingPayments.toString()}",
                  ),
                  // Specialized Navigation for the Low Stock alert
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
                      content: isLoading
                          ? "..."
                          : state.lowStockCount.toString(),
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

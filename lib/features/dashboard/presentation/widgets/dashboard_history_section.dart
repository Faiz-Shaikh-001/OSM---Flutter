import 'package:flutter/material.dart';
import 'package:osm/features/dashboard/presentation/widgets/historyGraph/bar_graph.dart';
import 'package:osm/features/orders/data/repositories/order_repository.dart';
import 'package:provider/provider.dart';

class DashboardHistorySection extends StatelessWidget {
  const DashboardHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    // List of weekly income
    List<double> weeklySummary = context.select((OrderRepository o) => o.weeklySummary);

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
}

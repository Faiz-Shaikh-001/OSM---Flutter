import 'package:flutter/material.dart';
import 'package:osm/features/dashboard/presentation/widgets/historyGraph/bar_graph.dart';
import 'package:osm/features/orders/data/repositories/order_repository.dart';
import 'package:provider/provider.dart';

class DashboardHistorySection extends StatelessWidget {
  const DashboardHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    // List of weekly income
    // List<double> weeklySummary = context.select((OrderRepository o) => o.weeklySummary);
    final orderRepository = Provider.of<OrderRepository>(
      context,
      listen: false,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Weekly Report",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        FutureBuilder<List<double>>(
          future: orderRepository.weeklySummary,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              final List<double> weeklySummary = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
              return SizedBox(
                height: 200,
                child:  HistoryBarGraph(weeklySummary: weeklySummary),
              );
            } else if (snapshot.hasError) {
              return SizedBox(
                height: 200,
                child: Center(child: Text("Error: ${snapshot.error}")),
              );
            } else if (snapshot.hasData) {
              List<double> weeklySummary = snapshot.data!;
              return SizedBox(
                height: 200,
                child: HistoryBarGraph(weeklySummary: weeklySummary),
              );
            } else {
              return const SizedBox(
                height: 200,
                child: Center(child: Text('No weekly data available.')),
              );
            }
          },
        ),
      ],
    );
  }
}

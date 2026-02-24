import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/dashboard/presentation/blocs/dashboard/dashboard_bloc.dart';
import 'package:osm/features/dashboard/presentation/widgets/historyGraph/bar_graph.dart';

class DashboardHistorySection extends StatelessWidget {
  const DashboardHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Weekly Report",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state.status == DashboardStatus.loading) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (state.status == DashboardStatus.failure) {
              return const SizedBox(
                height: 200,
                child: Center(child: Text("Failed to load chart data")),
              );
            }

            return SizedBox(
              height: 200,
              child: HistoryBarGraph(weeklySummary: state.weeklySalesData),
            );
          },
        ),
      ],
    );
  }
}

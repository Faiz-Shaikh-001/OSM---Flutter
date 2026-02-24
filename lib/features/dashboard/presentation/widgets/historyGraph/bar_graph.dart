import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:osm/features/dashboard/presentation/widgets/historyGraph/bar_data.dart';

class HistoryBarGraph extends StatelessWidget {
  final List<double> weeklySummary;

  const HistoryBarGraph({super.key, required this.weeklySummary});

  @override
  Widget build(BuildContext context) {
    final bool isDataEmpty = weeklySummary.every((v) => v == 0);

    final double maxEarning = isDataEmpty
        ? 0
        : weeklySummary.reduce((a, b) => a > b ? a : b);

    final double chartMaxY = maxEarning == 0 ? 100.0 : maxEarning * 1.2;

    Bardata myBarData = Bardata(
      sunAmount: weeklySummary[0],
      monAmount: weeklySummary[1],
      tueAmount: weeklySummary[2],
      wedAmount: weeklySummary[3],
      thurAmount: weeklySummary[4],
      friAmount: weeklySummary[5],
      satAmount: weeklySummary[6],
    );

    myBarData.initializeBarData();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BarChart(
              BarChartData(
                maxY: chartMaxY,
                minY: 0,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: chartMaxY / 5,
                  getDrawingHorizontalLine: (value) =>
                      FlLine(color: Colors.grey[200], strokeWidth: 1),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: getBottomTiles,
                    ),
                  ),
                ),
                barGroups: myBarData.barData
                    .map(
                      (data) => BarChartGroupData(
                        x: data.x,
                        barRods: [
                          BarChartRodData(
                            toY: data.y,
                            color: Colors.blue[800],
                            width: 15,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                            ),
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              toY: chartMaxY,
                              color: Colors.blue[50],
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),

          if (isDataEmpty)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bar_chart_rounded, color: Colors.grey),
                  Text(
                    "No earnings yet for this week",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

Widget getBottomTiles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('S', style: style);
      break;

    case 1:
      text = const Text('M', style: style);
      break;

    case 2:
      text = const Text('T', style: style);
      break;

    case 3:
      text = const Text('W', style: style);
      break;

    case 4:
      text = const Text('T', style: style);
      break;

    case 5:
      text = const Text('F', style: style);
      break;

    case 6:
      text = const Text('S', style: style);
      break;

    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(meta: meta, child: text);
}

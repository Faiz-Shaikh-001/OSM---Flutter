import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:osm/features/dashboard/presentation/widgets/historyGraph/bar_data.dart';

class HistoryBarGraph extends StatelessWidget {
  final List<double> weeklySummary;

  const HistoryBarGraph({super.key, required this.weeklySummary});

  @override
  Widget build(BuildContext context) {
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
      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1), borderRadius: BorderRadius.circular(15)),
      width: MediaQuery.of(context).size.width * .9,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          BarChartData(
            maxY: (weeklySummary.reduce((a, b) => a > b ? a : b) * 1.1),
            minY: 0,
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
                          toY:
                              (weeklySummary.reduce((a, b) => a > b ? a : b) *
                              1.1),
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

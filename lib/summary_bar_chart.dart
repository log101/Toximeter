import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _BarChart extends StatelessWidget {
  _BarChart(this.total, {Key? key}) : super(key: key);

  var total;
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: const EdgeInsets.all(0),
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.y.round().toString(),
          TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      getTextStyles: (context, value) => const TextStyle(
        color: Colors.blueGrey,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      margin: 20,
      getTitles: (double value) {
        switch (value.toInt()) {
          case 0:
            return 'Mn';
          case 1:
            return 'Te';
          case 2:
            return 'Wd';
          case 3:
            return 'Tu';
          case 4:
            return 'Fr';
          case 5:
            return 'St';
          case 6:
            return 'Sn';
          default:
            return '';
        }
      },
    ),
    leftTitles: SideTitles(showTitles: false),
    topTitles: SideTitles(showTitles: false),
    rightTitles: SideTitles(showTitles: false),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  List<BarChartGroupData> get barGroups => [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(y: 15, colors: [Colors.red, Colors.red.shade800],width: 16)
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(y: 10, colors: [Colors.red, Colors.red.shade800],width: 16)
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(y: 14, colors: [Colors.red, Colors.red.shade800],width: 16)
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(y: 15, colors: [Colors.red, Colors.red.shade800],width: 16)
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [
        BarChartRodData(y: 13, colors: [Colors.red, Colors.red.shade800],width: 16)
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 5,
      barRods: [
        BarChartRodData(y: 10, colors: [Colors.red, Colors.red.shade800],width: 16)
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 6,
      barRods: total.toDouble() == 0 ? null :
      [
        BarChartRodData(y: total.toDouble(), colors: [Colors.red, Colors.red.shade800],width: 16)
      ],
      showingTooltipIndicators: [0],
    ),
  ];
}

class SummaryBarChart extends StatefulWidget {
  SummaryBarChart(this.total);
  var total;

  @override
  State<StatefulWidget> createState() => SummaryBarChartState();
}

class SummaryBarChartState extends State<SummaryBarChart> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.limeAccent.shade100,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Weekly Toxic Exposure',
                    style: TextStyle(
                        color: const Color(0xff379982), fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '19-26 Sep 2021',
                    style: TextStyle(
                        color: const Color(0xff379982), fontSize: 16),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: _BarChart(widget.total),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/r.dart';

class ReportBarChart extends StatelessWidget {
  const ReportBarChart({Key? key}) : super(key: key);
  final Color dark = Colors.redAccent;
  final Color light = const Color(0xff73e8c9);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.66,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: BarChart(
          BarChartData(
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: bottomAxisTitles(),
              leftTitles: leftAxisTitles(),
              topTitles: nonAxisTitles(),
              rightTitles: nonAxisTitles(),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            gridData: FlGridData(
              show: true,
              checkToShowHorizontalLine: (value) => value % 10 == 0,
              getDrawingHorizontalLine: (value) => FlLine(
                color: const Color(0xffe7e8ec),
                strokeWidth: 1,
              ),
              drawVerticalLine: false,
            ),
            groupsSpace: 4,
            barGroups: getData(),
          ),
        ),
      ),
    );
  }

  AxisTitles nonAxisTitles() {
    return AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    );
  }

  AxisTitles bottomAxisTitles() {
    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 28,
        getTitlesWidget: bottomTitles,
      ),
    );
  }

  AxisTitles leftAxisTitles() {
    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        getTitlesWidget: leftTitles,
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Color(0xff939393), fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = R.Week1.tr;
        break;
      case 1:
        text = R.Week2.tr;
        break;
      case 2:
        text = R.Week3.tr;
        break;
      case 3:
        text = R.Week4.tr;
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      color: Colors.grey,
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  List<BarChartGroupData> getData() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 17000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 2000000000, dark),
              BarChartRodStackItem(2000000000, 17000000000, light),
            ],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5), topLeft: Radius.circular(5)),
            width: 30,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 17000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 2000000000, dark),
              BarChartRodStackItem(2000000000, 17000000000, light),
            ],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5), topLeft: Radius.circular(5)),
            width: 30,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 17000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 2000000000, dark),
              BarChartRodStackItem(2000000000, 17000000000, light),
            ],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5), topLeft: Radius.circular(5)),
            width: 30,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: 17000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 2000000000, dark),
              BarChartRodStackItem(2000000000, 17000000000, light),
            ],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5), topLeft: Radius.circular(5)),
            width: 30,
          ),
        ],
      ),
    ];
  }
}

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() {
  List<String> title_easy = ['M', 'T', 'W', 'T', 'F', 'Sa', 'Su'];
  List<String> title_complete = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  List<double> hights = [3, 4, 5, 6, 7, 1, 2];
  runApp(
    MaterialApp(
      title: 'Returning Data',
      home: Scaffold(
        appBar: AppBar(title: Text('Database')),
        body: BarChartSample1(title_easy, title_complete, hights),
      ),
    ),
  );
}

class BarChartSample1 extends StatefulWidget {
  List<String> title_easy = [];
  List<String> title_complete = [];
  List<double> hights = [];
  BarChartSample1(this.title_easy, this.title_complete, this.hights, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  int touchedIndex = -1;

  late double maxHeight = -1;

  @override
  Widget build(BuildContext context) {
    maxHeight = widget.hights
        .reduce((current, next) => current > next ? current : next);
    return Container(
      margin: EdgeInsets.all(5),
      height: 400,
      child: BarChart(
        mainBarData(),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.yellow,
          width: 25,
          // background of rod
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: maxHeight,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        return makeGroupData(i, widget.hights[i]);
      });

  Widget getTitles(double value, TitleMeta meta) {
    return Text(
      widget.title_easy[value.toInt()],
      style: const TextStyle(
        color: Color.fromARGB(255, 16, 14, 14),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      // data
      barGroups: showingGroups(),
      // the content of Axis
      titlesData: FlTitlesData(
        show: true,
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            // !!!! the content of Axis
            getTitlesWidget: getTitles,
            // stretch the bars.
            reservedSize: 200,
          ),
        ),
      ),
      // grid, default is true
      gridData: FlGridData(show: false),
      // border of whole grid, default is ture
      borderData: FlBorderData(
        show: false,
      ),
      barTouchData: BarTouchData(
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay = widget.title_complete[group.x.toInt()];

              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY).toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 40, 10, 101),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
      ),
      // scale of coordination
    );
  }
}

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:radius_v3/scenes/Owner_Pages/Data.dart';

class Analyzes_Card1 extends StatelessWidget {
  final List<Task> data;

  Analyzes_Card1({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Task, String>> series = [
      charts.Series(
        id: "NAME",
        data: data,
        domainFn: (Task series, _) => series.task,
        measureFn: (Task series, _) => series.taskValue,
        colorFn: (Task series, _) => series.colorValue,
      ),
    ];
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(top: 22),
          height: 260,
          width: 360,
          decoration: BoxDecoration(
            //color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: charts.BarChart(
            series,
            animationDuration: Duration(seconds: 4),
          ),
        ),
      ],
    );
  }
}

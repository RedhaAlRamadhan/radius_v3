import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// for charts
class Task {
  final String task;
  final double taskValue;
  final charts.Color colorValue;

  Task(
      {@required this.task,
      @required this.taskValue,
      @required this.colorValue});
}

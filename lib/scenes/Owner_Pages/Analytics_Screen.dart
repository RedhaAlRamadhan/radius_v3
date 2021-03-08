import 'package:flutter/material.dart';
import 'package:radius_v3/scenes/Owner_Pages/Analytics_Card1.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:radius_v3/scenes/Owner_Pages/Data.dart';

class Analytics_Screen extends StatefulWidget {
  @override
  _Analytics_ScreenState createState() => _Analytics_ScreenState();
}

class _Analytics_ScreenState extends State<Analytics_Screen> {
  final List<Task> data = [
    Task(
      task: 'Soled',
      taskValue: 100,
      colorValue: charts.ColorUtil.fromDartColor(Colors.white),
    ),
    Task(
      task: 'Profit',
      taskValue: 300,
      colorValue: charts.ColorUtil.fromDartColor(Colors.white),
    ),
    Task(
      task: 'Lost',
      taskValue: 10,
      colorValue: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    Task(
      task: 'Customers',
      taskValue: 260,
      colorValue: charts.ColorUtil.fromDartColor(Colors.white),
    ),
    Task(
      task: 'Goal',
      taskValue: 100,
      colorValue: charts.ColorUtil.fromDartColor(Colors.white),
    ),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IndexedStack(
          index: _index,
          children: [
            Container(
                //color: Colors.teal,
                child: Analyzes_Card1(data: data)),
            Container(
                //color: Colors.red,
                child: Analyzes_Card1(data: data)),
            Container(
                //color: Colors.purple,
                child: Analyzes_Card1(data: data)),
          ],
        ),
        Container(
          alignment: Alignment.topCenter,
          //color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (_index <= 0) return;
                  setState(() {
                    _index -= 1;
                  });
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_index >= 2) return;
                  setState(() {
                    _index += 1;
                  });
                },
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ),
        )
      ],
    );

    //   ListView.builder(
    //   scrollDirection: Axis.horizontal,
    //   padding: const EdgeInsets.all(1),
    //   itemCount: 2,
    //   itemBuilder: (BuildContext context, int index) {
    //     return Container(
    //       //color: Theme.of(context).accentColor,
    //       child: Stack(
    //         alignment: Alignment.center,
    //         children: [
    //           Analyzes_Cards(
    //             data: data,
    //           ),
    //       ],),
    //     );
    //   },
    // );
  }
}

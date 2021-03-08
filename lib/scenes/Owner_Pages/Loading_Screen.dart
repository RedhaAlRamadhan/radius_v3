import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadinScreen extends StatefulWidget {
  @override
  _LoadinScreenState createState() => _LoadinScreenState();
}

class _LoadinScreenState extends State<LoadinScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Loading',
            style: TextStyle(
              fontSize:60,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          SpinKitRing(
            color: Colors.white,
            size: 250.0,
          ),
        ],
      ),
    );
  }
}

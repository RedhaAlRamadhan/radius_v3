import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radius_v3/scenes/Owner_Pages/Orders_Cards.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    print(_height);
    double _scheight(_height) {
      if (_height < 700 || _height <= 500) {
        _height = _height - 560;
      } else if (_height < 900 || _height >= 700) {
        _height = _height - 660;
      } else if (_height > 900) {
        _height = _height - 900;
      }
      return _height;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        //color: Colors.red,
        width: _width,
        height: _height,
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(top: _scheight(_height) - 65),
                child: Cards()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: _scheight(_height),
                  width: _width - 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(100, 30),
                      bottomLeft: Radius.elliptical(100, 30),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        FontAwesomeIcons.solidArrowAltCircleLeft,
                        color: Theme.of(context).accentColor,
                        size: 40,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
            Container(
              height: _scheight(_height),
              width: _width - 10,
              alignment: Alignment.center,
              //color: Colors.white,
              child: Text(
                'Orders'.toUpperCase(),
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 50),
              ),
            )
          ],
        ),
      ),
    );
  }
}

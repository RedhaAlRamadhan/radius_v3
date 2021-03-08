import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cards extends StatefulWidget {
  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  CreatAlertDielog( BuildContext context){
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text(
          'Order Information',
          textAlign: TextAlign.center ,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 35,
          ),
        ),
        insetPadding: EdgeInsets.all(10),
        elevation: 5,
      actions: [
         Stack(
      //
      //     alignment: Alignment.topCenter,
      //     //overflow: Overflow.visible,
           children: [
            Container(
              alignment: Alignment.topLeft,
              height: 25,
              width: 300,
              //color: Colors.green,
              child: Text(
                'Hi',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              alignment: Alignment.topLeft,
              height: 25,
              width: 300,
              //color: Colors.green,
              child: Text(
                'Hi',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
              alignment: Alignment.topLeft,
              height: 25,
              width: 300,
              //color: Colors.green,
              child: Text(
                'Hi',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
              alignment: Alignment.topLeft,
              height: 25,
              width: 300,
              //color: Colors.green,
              child: Text(
                'Hi',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
              alignment: Alignment.topLeft,
              height: 25,
              width: 300,
              //color: Colors.green,
              child: Text(
                'Hi',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
              alignment: Alignment.center,
              height: 40,
              width: 350,
              child: Text(
                'Customer Inoformation',style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 145, 0, 0),
              alignment: Alignment.topLeft,
              height: 25,
              width: 300,
              //color: Colors.green,
              child: Text(
                'Hi',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 165, 0, 0),
              alignment: Alignment.topLeft,
              height: 25,
              width: 300,
              //color: Colors.green,
              child: Text(
                'Hi',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 185, 0, 0),
              alignment: Alignment.topLeft,
              height: 25,
              width: 300,
              //color: Colors.green,
              child: Text(
                'Hi',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
         ],),
        MaterialButton(
            child: Icon(
              Icons.cancel,
              size: 40,
              color: Colors.red[300],),
            onPressed: (){
              Navigator.of(context).pop();
            }
        ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(1),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            Container(
            margin: EdgeInsets.all(2),
            height: 90,
            width: _width-5,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
            BoxShadow(
            color: Colors.grey[400],
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(4,3),
            ),
            ],
            )
            ),
            Container(
              alignment: Alignment.topLeft,
              //color: Colors.blue,
              height: 20,
              width: 120,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text('Ticket Num $index: ',style: TextStyle(fontSize: 15,
              fontWeight: FontWeight.w900,),),
            ),
            Container(
              alignment: Alignment.centerLeft,
              //color: Colors.green,
              height: 20,
              width: 120,
              margin: EdgeInsets.fromLTRB(10, 37, 10, 0),
              child: Text('Customer name:',style: TextStyle(fontSize: 15,
                fontWeight: FontWeight.w900,),),
            ),
            Container(
              alignment: Alignment.centerLeft,
              //color: Colors.green,
              height: 20,
              width: 130,
              margin: EdgeInsets.fromLTRB(10, 67, 10, 0),
              child: Text('Customer phone :',style: TextStyle(fontSize: 15,
                fontWeight: FontWeight.w900,),),
            ),
            Container(
              alignment: Alignment.topLeft,
              //color: Colors.blue,
              height: 20,
              width: 200,
              margin: EdgeInsets.fromLTRB(110, 10, 10, 0),
              child: Text('#128379382912 ',style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,),),
            ),
            Container(
              alignment: Alignment.topLeft,
              //color: Colors.blue,
              height: 20,
              width: 200,
              margin: EdgeInsets.fromLTRB(130, 39, 10, 0),
              child: Text('Ahmed',style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,),),
            ),
            Container(
              alignment: Alignment.topLeft,
              //color: Colors.blue,
              height: 20,
              width: 150,
              margin: EdgeInsets.fromLTRB(135, 69, 10, 0),
              child: Text('+966475365244',style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,),),
            ),
            Container(
              //color: Colors.green,
                margin: EdgeInsets.fromLTRB(259, 5, 0, 10),
                height: 30,
                width: 30,
                child: Icon(FontAwesomeIcons.moneyCheck,
                  size: 16,
                  color: Colors.green[200],),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                )
            ),
            Container(
                margin: EdgeInsets.fromLTRB(264, 36, 0, 10),
                height: 10,
                width: 10,
                child: Icon(FontAwesomeIcons.tasks,
                  size: 21,
                  color: Colors.red[200],),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                )
            ),
            Container(
                margin: EdgeInsets.fromLTRB(265, 62, 0, 10),
                height: 10,
                width: 10,
                child: Icon(FontAwesomeIcons.solidCheckSquare,
                  size: 23,
                  color: Colors.red[200],),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(_width-90, 10, 0, 0),
                  alignment: Alignment.center,
                  height: 23,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green[200],
                  ),
                  child: Text('Payed',style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(_width-90, 3, 0, 0),
                  alignment: Alignment.center,
                  height: 23,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red[200],
                  ),
                  child: Text('Progress',style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(_width-90, 3, 0, 0),
                  alignment: Alignment.center,
                  height: 23,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red[200],
                  ),
                  child: Text('Delivered',style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),),
                ),
              ],
            ),
              InkWell(
                onTap: () {
                  CreatAlertDielog(context);
                  print('$index');
                  },
              child: GestureDetector(
                child: Container(
                  color: Colors.transparent,
                  height: 90,
                ),
              ),
            ),
            // AnimatedContainer(
            //       child: InkWell(
            //         onTap: () {setState(() {
            //           animatossize == 90 ? animatossize = animatossize+400 : animatossize = 90;
            //         });},
            //       ),
            //   height: animatossize,
            //   duration: Duration(seconds: 2),
            //   curve: Curves.easeIn,
            //   margin: EdgeInsets.all(2),
            //   decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(10),
            //   boxShadow: [
            //   BoxShadow(
            //   color: Colors.grey[400],
            //   spreadRadius: 2,
            //   blurRadius: 2,
            //   offset: Offset(4,3),
            //   ),
            //   ],
            //   )
            // ),
            // Container(
            //   margin: EdgeInsets.fromLTRB(305, 45, 0, 10),
            //   height: 20,
            //   width: 20,
            //   //color: Colors.deepPurpleAccent,
            //   child: IconButton(
            //     icon: Icon(Icons.arrow_drop_down),
            //     iconSize: 45,
            //     color: Colors.black45,
            //     onPressed: (){},
            //   ),
            // ),
          ],
        );
        },
        ),
        ),
        );
  }
}


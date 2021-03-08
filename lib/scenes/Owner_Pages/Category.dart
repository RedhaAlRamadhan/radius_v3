import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<num> list= [1,2,3,4,5,6,7,8,9,10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(10, (index) {
          return Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            FlatButton(
              padding: EdgeInsets.only(left: 21,right:1 ),
              onPressed: (){print('$index');},
              child: Container(
                alignment: Alignment.center,
                 margin: EdgeInsets.all(3),
                //color: Colors.red,
                height: 65,
                width: 65,
                child: Text('All $index',
                  style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                ),),
                decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(20),
                // boxShadow: [BoxShadow(
                //   color: Colors.grey[400],
                //   spreadRadius: 2,
                //   blurRadius: 2,
                //   offset: Offset(2,2),
                // ),],
              ),
              ),
            ),
          ],);
        }),
      ),
    );
  }
}

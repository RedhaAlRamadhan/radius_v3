import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radius_v3/scenes/Owner_Pages/Category.dart';
import 'package:radius_v3/scenes/Owner_Pages/Data.dart';
import 'package:radius_v3/scenes/Owner_Pages/Menu_Cards.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    print(_height);
    double _scheight(_height) {
      if (_height < 700 || _height <= 500) {
        _height = _height - 270;
      } else if (_height < 900 || _height >= 700) {
        _height = _height - 370;
      } else if (_height > 900) {
        _height = _height - 450;
      }
      return _height;
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).accentColor,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (_index) {
          showModalBottomSheet(
            context: context,
            //isScrollControlled: true,
            builder: (BuildContext context) {
              return Scaffold(
                resizeToAvoidBottomInset: true,
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).accentColor,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 100, top: 10),
                            child: Text(
                              'Add A Meal',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: IconButton(
                              padding: EdgeInsets.only(left: 65, top: 10),
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.red[400],
                                size: 40,
                              ),
                              //onPressed: (){},
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 60),
                        height: 50,
                        width: 250,
                        color: Colors.white,
                        child: TextField(
                          maxLength: 12,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Item Name',
                            labelText: 'Name',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 290, top: 60),
                        height: 50,
                        width: 80,
                        color: Colors.white,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Item Price',
                            labelText: 'Price',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 80, top: 175),
                        height: 100,
                        width: 230,
                        color: Colors.white,
                        child: TextField(
                          maxLines: 3,
                          maxLength: 67,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Item Information',
                            labelText: 'Information',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 290, top: 115),
                        height: 50,
                        width: 80,
                        color: Colors.white,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Discount ot of %100',
                            labelText: 'Discount',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 115),
                        height: 50,
                        width: 250,
                        color: Colors.white,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Upload Image ',
                            labelText: 'Image URL',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 380),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlatButton(
                              child: Icon(
                                FontAwesomeIcons.solidPlusSquare,
                                color: Theme.of(context).primaryColor,
                                size: 45,
                              ),
                              //shape: ,
                              onPressed: () {
                                print('Add item');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            // title: Text('Menu',style: TextStyle(
            //   fontSize: 20,
            //   fontWeight: FontWeight.w900,
            //   letterSpacing: 1.2,
            // ),),
            title: SizedBox.shrink(),
            icon: Icon(
              Icons.add_box_rounded,
              color: Theme.of(context).accentColor,
              size: 45,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: _scheight(_height) - 293),
            child: Menu_Cards(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 180,
                width: 392,
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
            margin: EdgeInsets.only(
              left: 120,
              top: 25,
            ),
            height: 55,
            width: 300,
            //color: Colors.white,
            child: Text(
              'Menu'.toUpperCase(),
              style:
                  TextStyle(color: Theme.of(context).accentColor, fontSize: 50),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 90),
                height: 80,
                width: 390,
                child: Category(),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 20),
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
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radius_v3/scenes/Owner_Pages/Analytics_Screen.dart';
import 'package:radius_v3/scenes/Owner_Pages/Menu_Screen.dart';
import 'package:radius_v3/scenes/Owner_Pages/Orders_screen.dart';

class Home_Owener extends StatefulWidget {
  @override
  _Home_OwenerState createState() => _Home_OwenerState();
}

class _Home_OwenerState extends State<Home_Owener> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _index;

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
      backgroundColor: Theme.of(context).accentColor,
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            Stack(children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://www.teenaagnel.com/wp-content/uploads/2019/12/food-photography-in-dubai.jpg'),
                  ),
                ),
              ),
              Container(
                //color: Colors.red,
                padding: EdgeInsets.fromLTRB(100, 10, 50, 0),
                width: 80,
                height: 80,
                child: Icon(
                  FontAwesomeIcons.solidUserCircle,
                  color: Colors.white,
                  size: 80,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 90),
                alignment: Alignment.center,
                //color: Colors.black,
                height: 70,
                width: 300,
                child: Text(
                  'Restaurant Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 2),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 161),
                height: 670,
                width: 305,
                color: Theme.of(context).accentColor,
              ),
              Column(
                children: [
                  Container(
                    //color: Colors.red,
                    padding: EdgeInsets.fromLTRB(70, 170, 0, 0),
                    child: ListTile(
                      title: Text(
                        'Account',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    //color: Colors.black,
                    padding: EdgeInsets.fromLTRB(70, 10, 0, 0),
                    child: ListTile(
                      title: Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    //color: Colors.black,
                    padding: EdgeInsets.fromLTRB(70, 10, 0, 0),
                    child: ListTile(
                      title: Text(
                        'Settings2',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    //color: Colors.black,
                    padding: EdgeInsets.fromLTRB(70, 10, 0, 0),
                    child: ListTile(
                      title: Text(
                        'Settings3',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    //color: Colors.black,
                    padding: EdgeInsets.fromLTRB(70, 10, 0, 0),
                    child: ListTile(
                      title: Text(
                        'Settings4',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    //color: Colors.black,
                    padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                    child: ListTile(
                      title: Text(
                        'Settings5',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    //color: Colors.black,
                    padding: EdgeInsets.fromLTRB(70, 10, 0, 0),
                    child: ListTile(
                      title: Text(
                        'Settings6',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
              scrollDirection: Axis.vertical,
              //padding: const EdgeInsets.all(1),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  //width: _scheight(_height),
                  //height: _width-10,
                  //color: Colors.red,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: _scheight(_height) - 35,
                                ),
                                height: 135,
                                width: 165,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 2,
                                        offset: Offset(0, 0),
                                        spreadRadius: 5,
                                      ),
                                    ]),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: _scheight(_height) - 35, left: 20),
                                height: 135,
                                width: 165,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 2,
                                        offset: Offset(0, 0),
                                        spreadRadius: 5,
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 5,
                                ),
                                height: 135,
                                width: 165,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 2,
                                        offset: Offset(0, 0),
                                        spreadRadius: 5,
                                      ),
                                    ]),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5, left: 20),
                                height: 135,
                                width: 165,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 2,
                                        offset: Offset(0, 0),
                                        spreadRadius: 5,
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(26, 380, 0, 0),
                          //color: Colors.red,
                          width: 150,
                          height: 50,
                          child: Text(
                            'Total Sales',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(210, 380, 0, 0),
                          //color: Colors.red,
                          width: 150,
                          height: 50,
                          child: Text(
                            'Total Profit',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(40, 520, 0, 0),
                          //color: Colors.red,
                          width: 130,
                          height: 60,
                          child: Text(
                            '     Total Customers',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(190, 530, 0, 0),
                          //color: Colors.red,
                          width: 190,
                          height: 30,
                          child: Text(
                            'Total Orders',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(210, 570, 0, 0),
                          //color: Colors.red,
                          width: 150,
                          height: 60,
                          child: Text(
                            '586',
                            style: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          )),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(30, 570, 0, 0),
                          //color: Colors.red,
                          width: 150,
                          height: 60,
                          child: Text(
                            '543',
                            style: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          )),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(220, 430, 0, 0),
                          //color: Colors.red,
                          width: 140,
                          height: 60,
                          child: Text(
                            '243',
                            style: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          )),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(28, 430, 0, 0),
                          //color: Colors.red,
                          width: 150,
                          height: 60,
                          child: Text(
                            '178',
                            style: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          )),
                    ],
                  ),
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: _scheight(_height) + 10,
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
            alignment: Alignment.center,
            height: _scheight(_height) - 310,
            width: _width - 10,
            //color: Colors.white,
            child: Text(
              'Analysis'.toUpperCase(),
              style:
                  TextStyle(color: Theme.of(context).accentColor, fontSize: 50),
            ),
          ),
          Container(
            child: Positioned(
              height: _scheight(_height) - 200,
              //width: _scheight(_height)-90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                    ),
                    child: TextButton(
                      child: Text(
                        '1D',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        print('1D');
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                    ),
                    child: TextButton(
                      child: Text(
                        '1W',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        print('1W');
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                    ),
                    child: TextButton(
                      child: Text(
                        '1M',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        print('1M');
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                    ),
                    child: TextButton(
                      child: Text(
                        '4M',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        print('4M');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: _scheight(_height) - 325,
            ),
            //height: _scheight(_height) - 130,
            //width: 370,
            //color: Colors.red,
            child: Analytics_Screen(),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 20),
            height: 50,
            width: 300,
            child: Row(
              children: [
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.cogs,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (_index) {
          setState(() {
            if (_index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuScreen(),
                ),
              );
            } else if (_index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrdersScreen(),
                ),
              );
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            // title: Text('Menu',style: TextStyle(
            //   fontSize: 20,
            //   fontWeight: FontWeight.w900,
            //   letterSpacing: 1.2,
            // ),),
            title: SizedBox.shrink(),
            icon: Icon(
              FontAwesomeIcons.utensils,
              color: Theme.of(context).primaryColor,
              size: 35,
            ),
          ),
          BottomNavigationBarItem(
            title: SizedBox.shrink(),
            icon: Icon(
              Icons.format_align_center,
              color: Theme.of(context).primaryColor,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}

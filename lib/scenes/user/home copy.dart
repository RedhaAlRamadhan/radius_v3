import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:ffi';
import 'dart:math';
import 'dart:io' show Platform;
// import 'package:barcode/barcode.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:radius_v3/model/order.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:radius_v3/model/resturant.dart';
import 'package:radius_v3/scenes/user/menu copy.dart';

import '../../signin_page.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with WidgetsBindingObserver {
  var tag;
  bool found = false;
  var isRunning = true;
  final resturantsList = <Resturant>[];

  final StreamController<BluetoothState> streamController = StreamController();
  StreamSubscription<BluetoothState> _streamBluetooth;
  StreamSubscription<RangingResult> _streamRanging;
  final foundBeacons = <String, Resturant>{};
  int d = 3;
  int orderStatus = 0;
  final _beacons = <Beacon>[];
  final regions = <Region>[];
  bool authorizationStatusOk = false;
  bool locationServiceEnabled = false;
  bool bluetoothEnabled = false;
  var mDatabase = FirebaseDatabase.instance.reference();
  final orders = <Order>[];

  @override
  void initState() {
    print(FirebaseAuth.instance.currentUser);
    WidgetsBinding.instance.addObserver(this);

    // DatabaseReference mDatabase;
    // FirebaseDatabase.instance
    //     .reference()
    //     .child("A")
    //     .set({'name': 'aaaaaaaa', 'description': 'aaaaaaaa'});

    print("hello");

    try {
      mDatabase.child("Resturants").once().then((DataSnapshot snapshot) {
// Map<dynamic, dynamic> values = snapshot.data.value;
//     values.forEach((key, values) {
//       needs.add(Need.fromSnapshot(values));
//     });
        Map<dynamic, dynamic> map = snapshot.value;

        // print(snapshot.value.entries.length);
        map.forEach((key, value) {
          try {
            // print(key.toString() + " key");
            regions.add(
              Region(
                identifier: key.toString(),
                proximityUUID: value['uuid'],
              ),
            );
          } catch (e) {}
        });
        // print("asd" + " Here");
        // int length = map.length;
        // for (int i = 0; i < length; i++) {
        //   print(map[i]);
        //   regions.add(
        //     Region(
        //       identifier: map[i].keys.toString(),
        //       proximityUUID: map[i]['uuid'],
        //     ),
        //   );
        // }

        // // print(user);
      }).whenComplete(() => mDatabase
              .child("Users")
              .child(FirebaseAuth.instance.currentUser.uid)
              .child("Orders")
              .once()
              .then((DataSnapshot snapshot) {
            print("Order Quantity " + snapshot.value.length.toString());
            Map<dynamic, dynamic> map = snapshot.value;
            print("Order Quantity " + map.toString());
            map.forEach((key, value) {
              print("Order ID " + key);
              print("Restuarante Ref " + value['RestauranteRef']);
              mDatabase
                  .child("Orders")
                  .child(key)
                  .once()
                  .then((DataSnapshot snapshot) {
                try {
                  orderStatus = snapshot.value['Status'];
                } catch (e) {
                  print(e);
                }
              });
              Resturant tempRestaurante = new Resturant();
              mDatabase
                  .child("Resturants")
                  .child(value['RestauranteRef'])
                  .once()
                  .then((DataSnapshot snapshot) {
                // Map<dynamic, dynamic> map = snapshot.value;
                // print(snapshot.value.toString() + " WHY wait");

                try {
                  // print(snapshot.value['ImageURL'] + " WHY");
                  tempRestaurante = Resturant(
                    avaliable: bool.fromEnvironment(
                        snapshot.value['Availability'].toString()),
                    imageURL: snapshot.value['ImageURL'],
                    title: snapshot.value['name'],
                    uuid: snapshot.key,
                  );
                  print(tempRestaurante.imageURL);
                } catch (e) {
                  print(e);
                }
              }).whenComplete(() => setState(() {
                        print(key + "what is dis");
                        orders.add(Order(
                          orderID: int.parse(key),
                          restuarante: tempRestaurante,
                          status: orderStatus,
                        ));
                      }));
              // orders.add(
              //   Order(
              //     orderID: 1,
              //     restuarante: tempRestaurante
              //     status: value['Status'],
              //   ),
              // );
              // print(" " + tempRestaurante.imageURL);
            });
          }).whenComplete(() => listeningState()));
    } catch (e) {
      print(e);
    }

    super.initState();
  }

  listeningState() async {
    print('Listening to bluetooth state');
    _streamBluetooth = flutterBeacon
        .bluetoothStateChanged()
        .listen((BluetoothState state) async {
      print('BluetoothState = $state');
      streamController.add(state);

      switch (state) {
        case BluetoothState.stateOn:
          initScanBeacon();
          break;
        case BluetoothState.stateOff:
          await pauseScanBeacon();
          await checkAllRequirements();
          break;
      }
    });
  }

  checkAllRequirements() async {
    try {
      // if you want to manage manual checking about the required permissions
      await flutterBeacon.initializeScanning;

      // or if you want to include automatic checking permission
      await flutterBeacon.initializeAndCheckScanning;
    } on PlatformException catch (e) {
      // library failed to initialize, check code and message
      print(e);
    }

    final bluetoothState = await flutterBeacon.bluetoothState;
    final bluetoothEnabled = bluetoothState == BluetoothState.stateOn;
    final authorizationStatus = await flutterBeacon.authorizationStatus;
    final authorizationStatusOk =
        authorizationStatus == AuthorizationStatus.allowed ||
            authorizationStatus == AuthorizationStatus.always;
    final locationServiceEnabled =
        await flutterBeacon.checkLocationServicesIfEnabled;

    setState(() {
      this.authorizationStatusOk = authorizationStatusOk;
      this.locationServiceEnabled = locationServiceEnabled;
      this.bluetoothEnabled = bluetoothEnabled;
    });
  }

  initScanBeacon() async {
    await flutterBeacon.initializeScanning;
    await checkAllRequirements();
    if (!authorizationStatusOk ||
        !locationServiceEnabled ||
        !bluetoothEnabled) {
      print('RETURNED, authorizationStatusOk=$authorizationStatusOk, '
          'locationServiceEnabled=$locationServiceEnabled, '
          'bluetoothEnabled=$bluetoothEnabled');
      return;
    }
    // final regions = <Region>[
    //   Region(
    //     identifier: 'KFC',
    //     proximityUUID: 'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0',
    //   ),
    //   Region(
    //     identifier: 'Burger King',
    //     proximityUUID: 'f04cd654-871a-40e1-ba1a-a139b67dbddd',
    //   ),
    //   Region(
    //     identifier: 'McDonalds',
    //     proximityUUID: 'cce1cd20-0111-4466-9aef-37ff3d842154',
    //   ),
    // ];

    if (_streamRanging != null) {
      if (_streamRanging.isPaused) {
        _streamRanging.resume();
        return;
      }
    }

    _streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
      // print(result.beacons[0].proximityUUID);
      // print(result);
      if (result != null && mounted) {
        // print(result.beacons);
        if (result.beacons.isNotEmpty)
          setState(() {
            Resturant tempRestaurante;
            // _regionBeacons[result.region] = result.beacons;

            // print(result.beacons.length);

            for (var _beacon in result.beacons) {
              if (foundBeacons[_beacon.proximityUUID] == null)
                mDatabase
                    .child("Resturants")
                    .child(_beacon.proximityUUID.toString())
                    .once()
                    .then((DataSnapshot snapshot) {
                  // print(1);
                  // Map<dynamic, dynamic> map = snapshot.value;
                  // print(2);
                  // print(map['name'].toString() + " WHY");
                  // print(snapshot.value);
                  // print("hello" + _beacon.proximityUUID);
                  try {
                    // print(3);

                    // print(snapshot.value['ImageURL'] + " WHY");
                    tempRestaurante = Resturant(
                      avaliable: snapshot.value['Availability'],
                      imageURL: snapshot.value['ImageURL'],
                      title: snapshot.value['name'],
                      uuid: snapshot.key,
                    );
                    // print(tempRestaurante.imageURL);
                    foundBeacons[_beacon.proximityUUID] = tempRestaurante;
                  } catch (e) {
                    print(e);
                  }
                });
            }
            // print(result.beacons.length.toString() +
            //     " " +
            //     resturantsList.length.toString());

            // _regionBeacons.values.forEach((list) {
            //   print("Found" + list.toString());
            //   found = true;
            //   // _beacons.addAll(list);
            // });
            // result.beacons.remove(result.beacons[0]);
            // _regionBeacons.clear();
            // print(_beacons.length);

            // _beacons.sort(_compareParameters);

            // for (var _beacon in _beacons) {
            // print('Ya Idiot ' + _beacon.toString());
            // regions.remove(_beacon);
            // _regionBeacons.remove(_beacon);
            // print(result.region.toJson.toString() + " Wierd");
            // for (var _resturant in resturants) {
            //   if (_beacon.proximityUUID == _resturant.uuid) {
            //     resturantsList.add(_resturant);
            //     break;
            //   }
            // }
            //   mDatabase
            //       .child("Resturants")
            //       .child("KFC")
            //       .once()
            //       .then((DataSnapshot snapshot) {
            //     Map<dynamic, dynamic> map = snapshot.value;
            //     // print(value['uuid'].toString() + " WHY");

            //     try {
            //       print(snapshot.value['ImageURL'] + " WHY");
            //       tempRestaurante = Resturant(
            //           avaliable: bool.fromEnvironment(
            //               snapshot.value['Availability'].toString()),
            //           imageURL: snapshot.value['ImageURL'],
            //           title: snapshot.key,
            //           uuid: snapshot.value['uuid'],
            //           items: <Item>[]);
            //       print(tempRestaurante.imageURL);
            //     } catch (e) {
            //       print(e);
            //     }
            //   }).whenComplete(() => setState(() {
            //             print(key + "what is dis");
            //             orders.add(Order(
            //               orderID: int.parse(key),
            //               restuarante: tempRestaurante,
            //               status: orderStatus,
            //             ));
            //           }));
            //   // orders.add(
            //   //   Order(
            //   //     orderID: 1,
            //   //     restuarante: tempRestaurante
            //   //     status: value['Status'],
            //   //   ),
            //   // );
            //   print(orders.length.toString() + " " + tempRestaurante.imageURL);
            // });
            // print("KK" + resturantsList.length.toString());
          });
        // else
        // found = false;
      }
    });
  }

  pauseScanBeacon() async {
    _streamRanging?.pause();
    if (_beacons.isNotEmpty) {
      setState(() {
        _beacons.clear();
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifecycleState = $state');
    if (state == AppLifecycleState.resumed) {
      if (_streamBluetooth != null && _streamBluetooth.isPaused) {
        _streamBluetooth.resume();
      }
      await checkAllRequirements();
      if (authorizationStatusOk && locationServiceEnabled && bluetoothEnabled) {
        await initScanBeacon();
      } else {
        await pauseScanBeacon();
        await checkAllRequirements();
      }
    } else if (state == AppLifecycleState.paused) {
      _streamBluetooth?.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    streamController?.close();
    _streamRanging?.cancel();
    _streamBluetooth?.cancel();
    flutterBeacon.close;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return new Scaffold(
      backgroundColor: new Color(0xFF222831),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut().whenComplete(() {
                  dispose();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                });
              })
        ],
        centerTitle: true,
        backgroundColor: new Color(0xFF393e46),
        title: Text(
          'Radius',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 75,
      ),
      body: Container(
        child: Stack(
          children: [
            LinearProgressIndicator(
              backgroundColor: Colors.cyan,
              minHeight: 5,
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          child: OrderCard(order: orders[index]),
                        );
                      },
                      childCount: orders.length,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Container(
                        child: ResturantCard(
                            resturant: foundBeacons.values.elementAt(index),
                            onPress: null),
                      );
                    }, childCount: foundBeacons.length),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Resturant createResturant(String resturanteRef) {
  //   Resturant tempResturant;
  //   bool why = false;
  //   print(resturanteRef + "jhgvjhg");
  //   mDatabase
  //       .child("Resturants")
  //       .child("KFC")
  //       .once()
  //       .then((DataSnapshot snapshot) {
  //     Map<dynamic, dynamic> map = snapshot.value;
  //     // print(value['uuid'].toString() + " WHY");

  //     try {
  //       print(snapshot.value['ImageURL'] + " WHY");
  //       tempResturant = Resturant(
  //           avaliable:
  //               bool.fromEnvironment(snapshot.value['Availability'].toString()),
  //           imageURL: snapshot.value['ImageURL'],
  //           title: snapshot.key,
  //           uuid: snapshot.value['uuid'],
  //           items: <Item>[]);
  //       print(tempResturant.imageURL);
  //     } catch (e) {
  //       print(e);
  //     }
  //   }).whenComplete(() => why = true);
  //   print(why);
  //   if (why) return tempResturant;
  // }
}

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PageController _pageController = PageController(
      initialPage: 0,
    );

    return GestureDetector(
      onTap: () {
        print("clicked");
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              // color: Color(0xFF00adb5),
              // gradient: LinearGradient(
              //   colors: [Colors.black45, Colors.white10],
              // ),
            ),
            height: 250,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Stack(fit: StackFit.expand, children: [
              BackgroundImage(image: order.restuarante.imageURL),
            ]),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xd0008f8f),
              // gradient: LinearGradient(
              //   colors: [Colors.black45, Colors.white10],
              // ),
            ),
            height: 250,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: PageView(
              physics: ClampingScrollPhysics(),
              pageSnapping: true,
              controller: _pageController,
              children: [
                Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    OrderInfo(
                      size: size,
                      title: order.restuarante.title,
                      status: order.status,
                    ),
                  ],
                ),
                Container(
                    // fit: StackFit.expand,
                    // child: SvgPicture.string(
                    //   Barcode.qrCode().toSvg(
                    //     order.orderID.toString(),
                    //     height: 100,
                    //   ),
                    //   color: Colors.white,
                    // ),
                    ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: WormEffect(
                  spacing: 8.0,
                  dotWidth: 10,
                  dotHeight: 10,
                  activeDotColor: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String image;
  const BackgroundImage({
    Key key,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ResturantCard extends StatelessWidget {
  final Resturant resturant;
  final Function onPress;
  final Function onSaved;
  final bool isSaved;

  const ResturantCard({
    Key key,
    @required this.resturant,
    @required this.onPress,
    this.onSaved,
    this.isSaved = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Menu(resturant)),
        );
      },
      child: Container(
        height: 250,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue[300],
                  strokeWidth: 5,
                ),
              ),
            ),
            BackgroundImage(image: resturant.imageURL),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: (resturant.avaliable)
                    ? LinearGradient(
                        begin: Alignment(-0.23, 0.9),
                        end: Alignment(0.0, 0.0),
                        colors: <Color>[
                          Color(0xd0000000),
                          Color(0x00000000),
                        ],
                      )
                    : null,
                color: (resturant.avaliable) ? null : Color(0xc05e5e5f),
              ),
            ),
            (resturant.avaliable)
                ? Container()
                : Positioned(
                    top: 3,
                    left: 10,
                    child: Chip(
                      label: Text('Unavailable'),
                    ),
                  ),
            ResturanteText(
              size: size,
              title: resturant.title,
            ),
          ],
        ),
      ),
    );
  }
}

class BookmarkButton extends StatelessWidget {
  final Function onPress;
  final double top, right;
  final bool active;

  const BookmarkButton({
    Key key,
    @required this.onPress,
    @required this.active,
    this.top = 10,
    this.right = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: 35,
      height: 35,
      top: 10,
      right: 10,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: IconButton(
          splashColor: Colors.transparent,
          icon: SvgPicture.asset(
            "assets/icons/heart.svg",
            color: active ? Colors.red : Colors.black.withOpacity(0.6),
          ),
          onPressed: onPress,
        ),
      ),
    );
  }
}

class ResturanteText extends StatelessWidget {
  final String title;
  final Size size;

  const ResturanteText({
    Key key,
    @required this.title,
    @required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned(
        bottom: 14,
        left: 10,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.title,
                style: TextStyle(
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 15)],
                  fontSize: size.width * 0.1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 2.5,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/hamburger.svg",
                    height: 40,
                  ),
                  Container(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    "assets/icons/chicken-leg.svg",
                    height: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderInfo extends StatelessWidget {
  final String title;
  final Size size;
  final int status;

  const OrderInfo({
    Key key,
    @required this.title,
    @required this.size,
    @required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(status.toString() + " Come here");
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Your Order",
            style: TextStyle(
              color: Colors.white,
              shadows: [Shadow(blurRadius: 10)],
              fontSize: size.width * 0.075,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 10,
          ),
          Stack(
            children: [
              Container(
                height: 160,
                child: Center(
                  heightFactor: 1,
                  child: Text(
                    (status == 0)
                        ? 'Await\nPayment'
                        : (status == 1)
                            ? "In\nProgress"
                            : (status == 2)
                                ? "Done"
                                : "ERROR",
                    style: TextStyle(
                      color: Colors.white,
                      shadows: [Shadow(blurRadius: 10)],
                      fontSize: size.width * 0.0725,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 165,
                  height: 165,
                  child: CircularProgressIndicator(
                    strokeWidth: 15,
                    backgroundColor: Colors.white60,
                    valueColor: AlwaysStoppedAnimation(Colors.deepOrange[400]),
                    value: (status / 2),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

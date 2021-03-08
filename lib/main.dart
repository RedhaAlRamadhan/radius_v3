import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:radius_v3/model/resturant.dart';
import 'package:radius_v3/register_page.dart';
import 'package:radius_v3/scenes/user/Home.dart';
import 'package:radius_v3/scenes/user/home copy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:radius_v3/signin_page.dart';
// import 'package:project/signin_page.dart';
// import 'package:radius_v3/test copy.dart';
// import 'package:project/login.dart';
// import 'package:radius_v3/FirebaseTest.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final FirebaseApp app = await Firebase.initializeApp(
  //   name: 'Grad-Project-Radius',
  //   options: Platform.isIOS || Platform.isMacOS
  //       ? FirebaseOptions(
  //           appId: '1:295360770785:ios:dc55c3799b89842a47fda0',
  //           apiKey: 'AIzaSyDj1rai8NRmHf9m8VYwrU20qWWdIhmDrIE',
  //           projectId: 'Grad-Project-Radius',
  //           messagingSenderId: '295360770785',
  //           databaseURL:
  //               'https://grad-project-radius-default-rtdb.firebaseio.com/',
  //         )
  //       : FirebaseOptions(
  //           appId: '1:295360770785:android:da6cbda9b703335047fda0',
  //           apiKey: 'AIzaSyDj1rai8NRmHf9m8VYwrU20qWWdIhmDrIE',
  //           messagingSenderId: '295360770785',
  //           projectId: 'Grad-Project-Radius',
  //           databaseURL:
  //               'https://grad-project-radius-default-rtdb.firebaseio.com/',
  //         ),
  // );
  runApp(
    MaterialApp(
      title: 'Navigation Basics',
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // Firestore.instance.collection('baby').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nearby',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              // User
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "User",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Open Homepage'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: Text(
                      'Open Home 45%',
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInPage(
                                // resturant: resturants[0],
                                )),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: Text('Open Cart'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: Text('Open Receipt'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                  // ElevatedButton(
                  //   child: Text('Test'),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => LoginPage()),
                  //     );
                  //   },
                  // ),
                  ElevatedButton(
                    child: Text('FirebaseTest'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                ],
              ),
            ), //----------------------End of User
            Container(
              //-----------------Owner
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "Owner",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Open Homepage'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: Text('Open Home 25%'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: Text('Open Order Info'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                ],
              ),
            ) //---------------------------End of Owner
          ],
        ),
      ),
    );
  }
}

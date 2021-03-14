// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:radius_v3/scenes/user/menu.dart';
// import 'package:radius_v3/globals.dart' as globals;
// import 'package:radius_v3/scenes/user/home copy.dart';
// // import 'package:radius_v3/login.dart';

// class Debug extends StatelessWidget {
//   // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//   // Firestore.instance.collection('baby').snapshots();
//   @override
//   Widget build(BuildContext context) {
//     print(globals.test);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Nearby',
//           style: TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Container(
//               // User
//               child: Column(
//                 children: [
//                   Container(
//                     child: Text(
//                       "User",
//                       style: TextStyle(
//                         fontSize: 20,
//                       ),
//                     ),
//                     padding: EdgeInsets.only(
//                       top: 5,
//                     ),
//                   ),
//                   ElevatedButton(
//                     child: Text('Open Homepage'),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Home()),
//                       );
//                     },
//                   ),
//                   ElevatedButton(
//                     child: Text(
//                       'Open Menu 45%',
//                     ),
//                     onPressed: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //       builder: (context) => Menu(
//                       //           // resturant: resturants[0],
//                       //           )),
//                       // );
//                     },
//                   ),
//                   ElevatedButton(
//                     child: Text('Open Cart'),
//                     onPressed: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => Menu()),
//                       // );
//                     },
//                   ),
//                   ElevatedButton(
//                     child: Text('Open Receipt'),
//                     onPressed: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => Menu()),
//                       // );
//                     },
//                   ),
//                   ElevatedButton(
//                     child: Text('Test'),
//                     onPressed: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => LoginPage()),
//                       // );
//                     },
//                   ),
//                   // ElevatedButton(
//                   //   child: Text('FirebaseTest'),
//                   //   onPressed: () {
//                   //     Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(builder: (context) => FirebaseTest()),
//                   //     );
//                   //   },
//                   // ),
//                 ],
//               ),
//             ), //----------------------End of User
//             Container(
//               //-----------------Owner
//               child: Column(
//                 children: [
//                   Container(
//                     child: Text(
//                       "Owner",
//                       style: TextStyle(
//                         fontSize: 20,
//                       ),
//                     ),
//                     padding: EdgeInsets.only(
//                       top: 5,
//                     ),
//                   ),
//                   ElevatedButton(
//                     child: Text('Open Homepage'),
//                     onPressed: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => Menu()),
//                       // );
//                     },
//                   ),
//                   ElevatedButton(
//                     child: Text('Open Menu 25%'),
//                     onPressed: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => Menu()),
//                       // );
//                     },
//                   ),
//                   ElevatedButton(
//                     child: Text('Open Order Info'),
//                     onPressed: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => Menu()),
//                       // );
//                     },
//                   ),
//                 ],
//               ),
//             ) //---------------------------End of Owner
//           ],
//         ),
//       ),
//     );
//   }
// }

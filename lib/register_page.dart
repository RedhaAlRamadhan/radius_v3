import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:radius_v3/scenes/user/home copy.dart';

class RegisterPage extends StatefulWidget {
  bool value;
  RegisterPage(this.value);
  @override
  _RegisterPageState createState() => _RegisterPageState(this.value);
}

class _RegisterPageState extends State<RegisterPage>
    with WidgetsBindingObserver {
  String checkValue = "";

  var mDatabase = FirebaseDatabase.instance.reference();

  final _formKey = GlobalKey<FormState>();
  final emailTextEditController = new TextEditingController();
  final resturanteTextEditController = new TextEditingController();
  final firstNameTextEditController = new TextEditingController();
  final lastNameTextEditController = new TextEditingController();
  final passwordTextEditController = new TextEditingController();
  final confirmPasswordTextEditController = new TextEditingController();
  final uuidPasswordTextEditController = new TextEditingController();

  bool owner;
  int beaconStatus = -1;
  bool signuping = false;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _resturanteFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _uuidPasswordFocus = FocusNode();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _errorMessage = '';

  final StreamController<BluetoothState> streamController = StreamController();
  StreamSubscription<BluetoothState> _streamBluetooth;
  StreamSubscription<RangingResult> _streamRanging;
  final _regionBeacons = <Region, List<Beacon>>{};
  final _beacons = <Beacon>[];
  bool authorizationStatusOk = false;
  bool locationServiceEnabled = false;
  bool bluetoothEnabled = false;

  _RegisterPageState(this.owner);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();

    listeningState();
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
    final regions = <Region>[
      Region(
        identifier: 'Test',
      ),
    ];

    if (_streamRanging != null) {
      if (_streamRanging.isPaused) {
        _streamRanging.resume();
        return;
      }
    }

    _streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
      print(result);
      if (result != null && mounted) {
        if (result.beacons.isNotEmpty) {
          for (var _beacon in result.beacons) {
            if (_beacon.proximityUUID == checkValue) {
              setState(() {
                beaconStatus = 1;
              });
            }
          }
        }
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

  // int _compareParameters(Beacon a, Beacon b) {
  //   int compare = a.proximityUUID.compareTo(b.proximityUUID);

  //   if (compare == 0) {
  //     compare = a.major.compareTo(b.major);
  //   }

  //   if (compare == 0) {
  //     compare = a.minor.compareTo(b.minor);
  //   }

  //   return compare;
  // }

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

  void processError(final PlatformException error) {
    setState(() {
      _errorMessage = error.message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              child: (owner) ? createOwnerForm() : createNormalForm(),
            ),
          ),
          (signuping)
              ? SizedBox.expand(
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.white.withOpacity(0.8),
                      ),
                      Center(
                        child: SizedBox(
                          width: 250,
                          height: 250,
                          child: CircularProgressIndicator(
                            strokeWidth: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget createNormalForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Container(
                padding: EdgeInsets.only(top: 70),
                width: 500,
                height: 190,
                /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                child: Image.asset('assets/logo2.png')),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '$_errorMessage',
              style: TextStyle(fontSize: 14.0, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              style: TextStyle(fontSize: 20),
              validator: (value) {
                if (value.isEmpty ||
                    !value.contains('@') ||
                    !value.contains('.')) {
                  return 'Please enter a valid email.';
                }
                return null;
              },
              controller: emailTextEditController,
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
              textInputAction: TextInputAction.next,
              focusNode: _emailFocus,
              onFieldSubmitted: (term) {
                FocusScope.of(context).requestFocus(_firstNameFocus);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black26),
                hintText: 'Email',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 4,
                    bottom: 4,
                    right: 5,
                  ),
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your first name.';
                      }
                      return null;
                    },
                    controller: firstNameTextEditController,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    textInputAction: TextInputAction.next,
                    focusNode: _firstNameFocus,
                    onFieldSubmitted: (term) {
                      FocusScope.of(context).requestFocus(_lastNameFocus);
                    },
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black26),
                      hintText: 'First Name',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 4,
                    bottom: 4,
                    left: 5,
                  ),
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your last name.';
                      }
                      return null;
                    },
                    controller: lastNameTextEditController,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    textInputAction: TextInputAction.next,
                    focusNode: _lastNameFocus,
                    onFieldSubmitted: (term) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black26),
                      hintText: 'Last Name',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              style: TextStyle(fontSize: 20),
              validator: (value) {
                if (value.length < 8) {
                  return 'Password must be longer than 8 characters.';
                }
                return null;
              },
              autofocus: false,
              obscureText: true,
              controller: passwordTextEditController,
              textInputAction: TextInputAction.next,
              focusNode: _passwordFocus,
              onFieldSubmitted: (term) {
                FocusScope.of(context).requestFocus(_confirmPasswordFocus);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black26),
                hintText: 'Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              style: TextStyle(fontSize: 20),
              autofocus: false,
              obscureText: true,
              controller: confirmPasswordTextEditController,
              focusNode: _confirmPasswordFocus,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (passwordTextEditController.text.length > 8 &&
                    passwordTextEditController.text != value) {
                  return 'Passwords do not match.';
                }
                return null;
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black26),
                hintText: 'Confirm Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Container(
            width: 500,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await _signUpWithEmailAndPassword();
                  }
                },
                padding: EdgeInsets.all(12),
                color: Colors.lightGreen,
                child: Text('Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 30)),
              ),
            ),
          ),
          // Container(
          //   width: 500,
          //   child: Padding(
          //     padding: EdgeInsets.only(top: 10.0),
          //     child: RaisedButton(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(24),
          //       ),
          //       onPressed: () async {
          //         // if (_formKey.currentState.validate()) {
          //         //   _firebaseAuth
          //         //       .createUserWithEmailAndPassword(
          //         //           email: emailTextEditController.text,
          //         //           password: passwordTextEditController.text)
          //         //       .then(
          //         //     (onValue) {
          //         //       print(onValue);
          //         //     },
          //         //   ).catchError(
          //         //     (onError) {
          //         //       processError(onError);
          //         //     },
          //         //   );
          //         // }
          //       },
          //       padding: EdgeInsets.all(12),
          //       color: Colors.deepPurple,
          //       child: Text('Sign Up as a Restuarate Owner',
          //           style: TextStyle(color: Colors.white, fontSize: 30)),
          //     ),
          //   ),
          // ),

          // Padding(
          //     padding: EdgeInsets.zero,
          //     child: FlatButton(
          //       child: Text(
          //         'Cancel',
          //         style: TextStyle(color: Colors.black54),
          //       ),
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //     ))
        ],
      ),
    );
  }

  Widget createOwnerForm() {
    listeningState();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
                padding: EdgeInsets.only(
                  top: 70,
                ),
                width: 500,
                height: 190,
                /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                child: Image.asset('assets/logo2.png')),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '$_errorMessage',
              style: TextStyle(fontSize: 14.0, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              style: TextStyle(fontSize: 20),
              validator: (value) {
                if (value.isEmpty ||
                    !value.contains('@') ||
                    !value.contains('.')) {
                  return 'Please enter a valid email.';
                }
                return null;
              },
              controller: emailTextEditController,
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
              textInputAction: TextInputAction.next,
              focusNode: _emailFocus,
              onFieldSubmitted: (term) {
                FocusScope.of(context).requestFocus(_firstNameFocus);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black26),
                hintText: 'Email',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              style: TextStyle(fontSize: 20),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a valid Resturante Name.';
                }
                return null;
              },
              controller: resturanteTextEditController,
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
              textInputAction: TextInputAction.next,
              focusNode: _resturanteFocus,
              onFieldSubmitted: (term) {
                FocusScope.of(context).requestFocus(_firstNameFocus);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black26),
                hintText: 'Resturante Name',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 8.0),
          //   child: TextFormField(
          //     style: TextStyle(fontSize: 20),
          //     validator: (value) {
          //       if (value.isEmpty) {
          //         return 'Please enter a valid Resturante Descreption.';
          //       }
          //       return null;
          //     },
          //     autofocus: false,
          //     controller: passwordTextEditController,
          //     textInputAction: TextInputAction.next,
          //     focusNode: _passwordFocus,
          //     onFieldSubmitted: (term) {
          //       FocusScope.of(context).requestFocus(_confirmPasswordFocus);
          //     },
          //     decoration: InputDecoration(
          //       hintStyle: TextStyle(color: Colors.black26),
          //       hintText: 'Descreption of the Restuarante',
          //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(32.0)),
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              style: TextStyle(fontSize: 20),
              validator: (value) {
                if (value.length < 8) {
                  return 'Password must be longer than 8 characters.';
                }
                return null;
              },
              autofocus: false,
              obscureText: true,
              controller: passwordTextEditController,
              textInputAction: TextInputAction.next,
              focusNode: _passwordFocus,
              onFieldSubmitted: (term) {
                FocusScope.of(context).requestFocus(_confirmPasswordFocus);
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black26),
                hintText: 'Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              style: TextStyle(fontSize: 20),
              autofocus: false,
              obscureText: true,
              controller: confirmPasswordTextEditController,
              focusNode: _confirmPasswordFocus,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (passwordTextEditController.text.length > 8 &&
                    passwordTextEditController.text != value) {
                  return 'Passwords do not match.';
                }
                return null;
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black26),
                hintText: 'Confirm Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              onChanged: (value) async {
                if (value.isEmpty || value.contains(' ') || value.length < 32) {
                  setState(() {
                    beaconStatus = 0;
                    if (value == 'test') beaconStatus = 1;
                  });
                } else {
                  checkValue = value;
                  setState(
                    () {
                      beaconStatus = 0;
                    },
                  );
                }
              },
              style: TextStyle(fontSize: 20),
              autofocus: false,
              controller: uuidPasswordTextEditController,
              focusNode: _uuidPasswordFocus,
              textInputAction: TextInputAction.done,
              validator: (value) {
                // if (value == 'test') beaconStatus = 1;
                if (value.isEmpty || value.contains(' ')) {
                  return 'Please enter a valid Beacon UUID.';
                }
                return null;
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black26),
                hintText: 'Beacon\'s UUID*',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (beaconStatus == -1)
                        ? "Waiting for UUID"
                        : (beaconStatus == 0)
                            ? "Searching"
                            : (beaconStatus == 1)
                                ? "Beacon Found"
                                : "Error",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 2.5,
                  ),
                  (beaconStatus == -1)
                      ? Icon(
                          Icons.pending,
                          size: 20,
                        )
                      : (beaconStatus == 0)
                          ? SizedBox(
                              width: 10,
                              height: 10,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            )
                          : (beaconStatus == 1)
                              ? Icon(
                                  Icons.check_circle_outline,
                                  size: 20,
                                )
                              : Icon(
                                  Icons.error_outline,
                                  size: 20,
                                )
                ],
              )),
          Container(
            width: 500,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: RaisedButton(
                disabledColor: Colors.green[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: (beaconStatus == 1)
                    ? () async {
                        await _signUpWithEmailAndPassword();
                      }
                    : null,
                padding: EdgeInsets.all(12),
                color: Colors.lightGreen,
                child: Text('Signup',
                    style: TextStyle(color: Colors.white, fontSize: 30)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signUpWithEmailAndPassword() async {
    try {
      FocusScope.of(context).unfocus();
      setState(() {
        signuping = true;
      });
      if (_formKey.currentState.validate()) {
        await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditController.text,
                password: passwordTextEditController.text)
            .then(
          (value) {
            print(value);
            if (owner) {
              FirebaseDatabase.instance
                  .reference()
                  .child("Owners")
                  .child(value.user.uid)
                  .set(
                {
                  "Email": emailTextEditController.text,
                  "Resturante Title": resturanteTextEditController.text,
                  "Resturante UUID": uuidPasswordTextEditController.text,
                },
              );
            } else {
              FirebaseDatabase.instance
                  .reference()
                  .child("Users")
                  .child(value.user.uid)
                  .set(
                {
                  "Email": emailTextEditController.text,
                  "FirstName": firstNameTextEditController.text,
                  "LastName": lastNameTextEditController.text,
                },
              );
            }
          },
        ).catchError(
          (onError) {
            Scaffold.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('Failed to sign in with Email & Password. Try Againg'),
              ),
            );
            print(onError);
            processError(onError);
          },
        );
      }

      dispose();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (e) {
      setState(() {
        signuping = false;
      });
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign in with Email & Password. Try Againg'),
        ),
      );
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:radius_v3/globals.dart';
import 'package:radius_v3/model/resturant.dart';
import 'package:radius_v3/model/resturant.dart';
import 'dart:ffi';

class Cart extends StatefulWidget {
  @override
  _Cart createState() => _Cart();
}

class _Cart extends State<Cart> {
  int indexOfCategory = 0;

  int additionPrice = 0;
  List<bool> checkboxes = [];
  int quantity = 1;

  var mDatabase = FirebaseDatabase.instance.reference();

  // List<String> categories = [];

  @override
  void initState() {
    // mDatabase
    //     .reference()
    //     .child("Resturants")
    //     .child(resturant.uuid)
    //     .child("Items")
    //     .once()
    //     .then((snapshot) {
    //   map = snapshot.value;
    //   print(map.entries.elementAt(1).value.length);
    //   print(map.values.elementAt(0).values.elementAt(0));
    //   map.forEach((key, value) {
    //     // for (String _category in key) {
    //     // categories.add(key.toString());
    //     // }
    //     print(key);
    //     setState(() {});
    //   });
    // });
    // print(map['Extras']);
    print("Start");
    super.initState();
  }

  // Menu({this.resturant = resturant});
  @override
  Widget build(BuildContext context) {
    // print(map.entries.first.value['Extras']);

    // final String title = resturant.title;
    // print(categories.length);
    // print(resturant.items[0].imageURL);
    // if (categories.length != 0)
    return MaterialApp(
      title: 'Cart',
      home: Scaffold(
        // No appbar provided to the Scaffold, only a body with a
        // CustomScrollView.
        appBar: buildAppBar("Cart"),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: <Widget>[
                // Add the app bar to the CustomScrollView.

                SliverList(
                  // Use a delegate to build items as they're scrolled on screen.
                  delegate: SliverChildBuilderDelegate(
                    // The builder function returns a ListTile with a title that
                    // displays the index of the current item.
                    (content, index) {
                      return createContent(index);
                      // Text((map['Extras'] as Map)
                      //     .keys
                      //     .elementAt(index)
                      //     .toString());
                    },
                    childCount: cartContents.length,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 15,
              left: 10,
              child: GestureDetector(
                onTap: () {
                  // print("Pressed -");
                  // if (quantity > 1)
                  //   setState(() {
                  //     quantity--;
                  //   });
                  int orderID = 0;

                  mDatabase
                      .child("Orders")
                      .once()
                      .then((value) => orderID = value.value.length + 1)
                      .whenComplete(() {
                    mDatabase.child("Orders").child(orderID.toString()).set({
                      // '121':
                      "Status": 1,
                      "Uid": "FXOOc9QaExQLDMM5xraCLUH30Da2",
                      "RestauranteRef": "CCE1CD20-0111-4466-9AEF-37FF3D842154",
                      "Items": {
                        for (var _content in cartContents)
                          _content.title: {
                            "ID": _content.id.toString(),
                            "Quantity": _content.contentQuantity.toString()
                          }
                      },
                    }).whenComplete(() => print("Added"));
                    mDatabase
                        .child("Users")
                        .child(FirebaseAuth.instance.currentUser.uid)
                        .child("Orders")
                        .child(orderID.toString())
                        .set({
                      "RestauranteRef": resturanteRef,
                    });
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green[400],
                  ),
                  height: 50,
                  width: 432,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Checkout",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  totalPrice.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                Text(
                                  " Riyal",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            // Text(map.values.elementAt(0).toString())
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 5,
      title: Container(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 25,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centerTitle: true,
    );
  }

  Widget createContent(index) {
    print(checkboxes.length);
    // checkboxes[index] = false;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2.5,
        horizontal: 5,
      ),
      child: GestureDetector(
        onTap: () {
          // print(map.keys.elementAt(level));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => Item(map.values.elementAt(index)),
          //     ));
          setState(() {
            // checkboxes[checkboxes.length - 1] = false;
            // print("object " + index.toString() + checkboxes[index].toString());
            // checkboxes[index] = !checkboxes[index];
            // additionPrice = additionPrice +
            //     (map["Extras"].values.elementAt(index)['price'] *
            //         (checkboxes[index] ? 1 : -1));

            // print(quantity);
          });
        },
        child: Card(
            elevation: 1,
            // semanticContainer: true,
            child: Expanded(
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      cartContents[index].imageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartContents[index].title,
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                                Text(
                                  (cartContents[index].contentPrice *
                                          cartContents[index].contentQuantity)
                                      .toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              cartContents[index].contentQuantity != 1
                                  ? new IconButton(
                                      iconSize: 25,
                                      icon: new Icon(Icons.remove),
                                      onPressed: () {
                                        setState(() {
                                          cartContents[index].contentQuantity--;
                                          refreshTotalPrice();
                                        });
                                      },
                                    )
                                  : new Container(),
                              new Text(
                                cartContents[index].contentQuantity.toString(),
                                style: TextStyle(fontSize: 25),
                              ),
                              new IconButton(
                                  iconSize: 25,
                                  icon: new Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      cartContents[index].contentQuantity++;
                                      refreshTotalPrice();
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );

    // Text("asd");
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentHeader({this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      height: 60.5,
      child: Card(
        margin: EdgeInsets.all(0),
        color: Colors.white,
        elevation: 5.0,
        child: Center(child: widget),
      ),
    );
  }

  @override
  double get maxExtent => 47.5;

  @override
  double get minExtent => 47.5;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

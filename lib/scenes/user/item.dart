import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:radius_v3/globals.dart';
import 'package:radius_v3/main.dart';
import 'package:radius_v3/model/resturant.dart';
import 'package:radius_v3/model/resturant.dart';
import 'dart:ffi';

class Item extends StatefulWidget {
  final Map map;
  final int id;
  final int price;

  const Item({
    this.id,
    this.map,
    this.price,
  });
  Map toJson() => {
        'id': id,
        'map': map,
        'price': price,
      };

  @override
  _Item createState() => _Item(map, id, price);
}

class _Item extends State<Item> {
  int indexOfCategory = 0;
  final int id;
  final Map map;
  final int price;
  int additionPrice = 0;
  List<bool> checkboxes = [];
  int quantity = 1;

  var mDatabase = FirebaseDatabase.instance.reference();

  _Item(this.map, this.id, this.price);

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
    print(price);
    checkboxes = List(map["Extras"].values.length);
    for (var i = 0; i < checkboxes.length; i++) {
      checkboxes[i] = false;
    }
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
      title: map['title'],
      home: Scaffold(
        // No appbar provided to the Scaffold, only a body with a
        // CustomScrollView.
        appBar: buildAppBar(map["title"]),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: <Widget>[
                // Add the app bar to the CustomScrollView.
                SliverAppBar(
                  // Provide a standard title.

                  // title: Text(title),
                  // backgroundColor: Color(0xFFFFFF),

                  // Allows the user to reveal the app bar if they begin scrolling
                  // back up the list of items.
                  backgroundColor: Colors.black54,
                  floating: false,
                  pinned: false,
                  snap: false,
                  // Display a placeholder widget to visualize the shrinking size.
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: <StretchMode>[
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                      StretchMode.fadeTitle,
                    ],
                    // centerTitle: true,
                    // title: Text(title),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          map['imageURL'],
                          fit: BoxFit.cover,
                        ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.0, 0.5),
                              end: Alignment(0.0, 0.0),
                              colors: <Color>[
                                Color(0x60000000),
                                Color(0x00000000),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Make the initial height of the SliverAppBar larger than normal.
                  expandedHeight: 400,
                ),
                // Next, create a SliverList

                SliverList(
                  // Use a delegate to build items as they're scrolled on screen.
                  delegate: SliverChildBuilderDelegate(
                    // The builder function returns a ListTile with a title that
                    // displays the index of the current item.
                    (content, index) {
                      return createExtra(index);
                      // Text((map['Extras'] as Map)
                      //     .keys
                      //     .elementAt(index)
                      //     .toString());
                    },
                    childCount: map['Extras'].length,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 15,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green[400],
                ),
                height: 75,
                width: 432,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("Pressed -");
                            if (quantity > 1)
                              setState(() {
                                quantity--;
                              });
                          },
                          child: SizedBox(
                            child: Text(
                              "   −   ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        VerticalDivider(
                          thickness: 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            refreshTotalPrice();
                            cartContents.add(CartContent(id, map["title"],
                                map["imageURL"], price, quantity));
                            print("Pressed Add");
                            Navigator.pop(context);
                          },
                          child: SizedBox(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Column(
                                children: [
                                  Text(
                                    "    Add " + quantity.toString() + "    ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ((price + additionPrice) * quantity)
                                            .toString() +
                                        " Riyal",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        VerticalDivider(
                          thickness: 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Pressed +");
                            setState(() {
                              quantity++;
                            });
                          },
                          child: SizedBox(
                            // width: 10,
                            child: Text(
                              "   +   ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget createExtra(index) {
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
            checkboxes[index] = !checkboxes[index];
            additionPrice = additionPrice +
                (map["Extras"].values.elementAt(index)['price'] *
                    (checkboxes[index] ? 1 : -1));

            print(quantity);
          });
        },
        child: Card(
          elevation: 1,
          // semanticContainer: true,
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                child: Image.network(
                  map["Extras"].values.elementAt(index)['imageURL'],
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        map["Extras"].keys.elementAt(index).toString(),
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      (map["Extras"].values.elementAt(index)['price'] > 0)
                          ? Text(
                              "+ " +
                                  map["Extras"]
                                      .values
                                      .elementAt(index)['price']
                                      .toString(),
                              style: TextStyle(fontSize: 15),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Checkbox(
                  value: checkboxes[index],
                  onChanged: (value) {
                    checkboxes[index] = !checkboxes[index];
                  },
                ),
              )
            ],
          ),
        ),
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

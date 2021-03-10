import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:radius_v3/main.dart';
import 'package:radius_v3/model/resturant.dart';
import 'package:radius_v3/model/resturant.dart';

class Item extends StatefulWidget {
  final Map map;
  final int id;

  const Item({
    this.id,
    this.map,
  });
  Map toJson() => {
        'id': id,
        'map': map,
      };

  @override
  _Item createState() => _Item(map, id);
}

class _Item extends State<Item> {
  double price = 0;
  int indexOfCategory = 0;
  final int id;
  final Map map;

  var mDatabase = FirebaseDatabase.instance.reference();

  _Item(this.map, this.id);

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
    print(map["Extras"].values.elementAt(0)['imageURL']);
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
                height: 55,
                width: 432,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                    child: Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
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
    print(1);

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
                  value: false,
                  onChanged: (value) {
                    // !value;
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

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:radius_v3/model/resturant.dart';
import 'package:radius_v3/model/resturant.dart';
import 'package:radius_v3/scenes/user/item.dart';

class Menu extends StatefulWidget {
  final Resturant resturant;
  Menu(this.resturant);

  @override
  _Menu createState() => _Menu(resturant);
}

class _Menu extends State<Menu> {
  final Resturant resturant;
  double price = 0;
  int indexOfCategory = 0;

  var mDatabase = FirebaseDatabase.instance.reference();

  // List<String> categories = [];
  Map<dynamic, dynamic> map;

  _Menu(this.resturant);

  // initstat
  @override
  void initState() {
    mDatabase
        .reference()
        .child("Resturants")
        .child(resturant.uuid)
        .child("Items")
        .once()
        .then((snapshot) {
      // print(snapshot.value.toString());
      map = snapshot.value;
      // print(map.entries.elementAt(1).value.length);
      // print(map.values.elementAt(0).values.elementAt(0));
      map.forEach((key, value) {
        // for (String _category in key) {
        // categories.add(key.toString());
        // }
        print(value);
        setState(() {});
      });
    });
    print("Start");
    super.initState();
  }

  // Menu({this.resturant = resturant});
  @override
  Widget build(BuildContext context) {
    // final String title = resturant.title;
    // print(categories.length);
    // print(resturant.items[0].imageURL);
    // if (categories.length != 0)
    return MaterialApp(
      title: resturant.title,
      home: Scaffold(
        // No appbar provided to the Scaffold, only a body with a
        // CustomScrollView.
        appBar: buildAppBar(resturant.title),
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
                          resturant.imageURL,
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
                  expandedHeight: 300,
                ),
                // Next, create a SliverList
                SliverPersistentHeader(
                  pinned: true,
                  delegate: PersistentHeader(
                    widget: Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: map.values.length,
                        itemBuilder: (context, index) => Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                indexOfCategory = index;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              // color: Colors.green,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    map.keys.elementAt(index),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: index == indexOfCategory
                                          ? Colors.black
                                          : Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    width: 50,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: index == indexOfCategory
                                          ? Colors.black
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  // Use a delegate to build items as they're scrolled on screen.
                  delegate: SliverChildBuilderDelegate(
                    // The builder function returns a ListTile with a title that
                    // displays the index of the current item.
                    (content, index) {
                      return createItems(index);
                    },
                    childCount: map.keys.length,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "View Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          "50",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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

  Widget createItems(index) {
    print(1);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2.5,
        horizontal: 5,
      ),
      child: GestureDetector(
        onTap: () {
          print(map.values.elementAt(index));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Item(
                        map: map.values.elementAt(index),
                        id: int.parse(map.keys.elementAt(index).toString()),
                      )));
        },
        child: Card(
          elevation: 1,
          // semanticContainer: true,
          child: Row(
            children: [
              Container(
                height: 100,
                child: Image.network(
                  map.values.elementAt(index)['imageURL'],
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    map.values.elementAt(index)['title'],
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  map.values.elementAt(index)['price'].toString(),
                  style: TextStyle(fontSize: 24),
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

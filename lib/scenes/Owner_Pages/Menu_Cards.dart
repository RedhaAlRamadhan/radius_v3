import 'package:flutter/material.dart';

class Menu_Cards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<num> list= [1,2,3,4,5,6,7,8,9,10];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(list.length, (index) {
            return Container(
              //color: Colors.red,
              alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      height: 190,
                      width: 170,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(
                          color: Colors.grey[400],
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(2,2),
                        ),],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      height: 110,
                      width: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),),
                        boxShadow: [BoxShadow(
                          color: Colors.grey[400],
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1,1),
                        ),],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),),
                        child: Image(
                          image: NetworkImage('https://cdn10.phillymag.com/wp-content/uploads/sites/3/2020/05/alpen-rose-burger.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(17, 168, 0, 0),
                      height: 30,
                      width: 50,
                      child: Text('23\$',style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                      ),
                    ),
                    Container(
                      alignment:Alignment.center,
                      margin: EdgeInsets.fromLTRB(17, 80, 0, 0),
                      height: 33,
                      width: 145,
                      //color: Theme.of(context).accentColor,
                      child: Text('Burger Meat',style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        shadows: [Shadow(
                        color: Colors.black,
                        offset: Offset(-1,-1),
                        blurRadius: 4,
                        ),],
                        ),
                      ),
                      ),
                    Container(
                      alignment:Alignment.center,
                      margin: EdgeInsets.fromLTRB(18, 117, 0, 0),
                      height: 45,
                      width: 145,
                      //color: Theme.of(context).accentColor,
                      child: Text('infoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).accentColor,
                      ),
                      ),
                    ),
                    Container(
                      //color: Theme.of(context).primaryColor,
                      //alignment: Alignment.bottomRight,
                      padding: EdgeInsets.fromLTRB(135, 156, 0, 0),
                      width: 180,
                      height: 200,
                      child: IconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            size: 25,
                            color: Colors.black45,
                          ),
                          onPressed: () => print('Item $index'),
                      ),
                    ),
                  ],),
            );
          }),
        ),
      ),
    );
  }
}

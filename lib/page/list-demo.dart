import 'package:flutter/material.dart';

class ListDemo extends StatefulWidget {
  @override
  _ListDemoState createState() => _ListDemoState();
}

class _ListDemoState extends State<ListDemo> {
  List<String> list = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  List<Widget> cardList = new List();
  //  new List.generate( _count, (int i) => new createCard());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  delegate: new SliverChildBuilderDelegate((context, index) {
                    return cardList[
                        index]; // this is where the cards are displayed in a list
                  }, childCount: cardList.length)),
              // SliverGrid.count(
              //   crossAxisCount: 2,
              //   children: list
              //       .map((name) => GestureDetector(
              //             onTap: () {
              //               _globalKey.currentState.showSnackBar(SnackBar(content: Text("Card clicked"),));
              //             },
              //             child: Card(
              //               child: ListTile(
              //                 title: Text(name),
              //                 trailing: IconButton(
              //                   icon: Icon(
              //                     Icons.remove_circle,
              //                     color: Colors.red,
              //                   ),
              //                   onPressed: () {
              //               _globalKey.currentState.showSnackBar(SnackBar(content: Text("Delete clicked"),));
              //               },
              //                 ),
              //               ),
              //             ),
              //           ))
              //       .toList(),
              // ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            addItems();
          },
          heroTag: "btn2",
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void addItems() async {
    setState(() {
      cardList.insert(
          0,
          new GestureDetector(
              onTap: () async {
                _globalKey.currentState.showSnackBar(SnackBar(
                  content: Text("Card clicked"),
                ));
              },
              child: Card(
                child: Text("project 1"),
//                 child: ListTile(
//                   title: Text("project 1"),
//                   trailing: new Icon(
//                     Icons.remove_circle,
//                     color: Colors.redAccent,
//                   ),
// //                      subtitle: whitefontstylemont(text: "project 1", size: 20,)) //this is just a custom TextStyle
//                 ),
              )));
    });
  }
}

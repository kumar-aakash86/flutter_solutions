import 'package:demo1/page/drawing/google-drawing.dart';
import 'package:flutter/material.dart';
import './../../main.dart';

class DrawingList extends StatefulWidget {
  @override
  _DrawingListState createState() => _DrawingListState();
}

class _DrawingListState extends State<DrawingList> {
  List<ListModel> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    list = new List();
    list.add(ListModel("Google Drawing", GoogleDrawing()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Drawing List"),),
      body:ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(list[index].title),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => list[index].page));
              },
              trailing: Icon(Icons.chevron_right),
            );
          },
        ),
    );
  }
}
import 'package:flutter/material.dart';

class ListVsColumnDemo extends StatefulWidget {
  @override
  _ListVsColumnDemoState createState() => _ListVsColumnDemoState();
}

class _ListVsColumnDemoState extends State<ListVsColumnDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: getListBody(),
      )
    );
  }

  getColumnBody() {
    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
          color: Colors.red,
        ))
      ],
    );
  }

  getListBody() {
    return ListView(
      children: <Widget>[
        Container(
          color: Colors.yellow,
          child: SizedBox(
            height: 300,
          ),
        ),
      ],
    );
  }
}

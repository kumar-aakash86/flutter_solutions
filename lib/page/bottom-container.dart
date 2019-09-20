import 'package:flutter/material.dart';

class BottomContainer extends StatefulWidget {
  @override
  _BottomContainerState createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Header"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text("Hello"),
            ),
          ),
          Container(
            height: 50,
            width: double.maxFinite,
            decoration: BoxDecoration(
              
            color: Colors.deepOrange,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_forward), onPressed: (){},),
                IconButton(icon: Icon(Icons.arrow_downward), onPressed: (){},),
                IconButton(icon: Icon(Icons.arrow_left), onPressed: (){},),
                IconButton(icon: Icon(Icons.arrow_upward), onPressed: (){},),
              ],
            ),
          )
        ],
      ),
    );
  }
}
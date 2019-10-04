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
        body: Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text("Hello"),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                        ),
                      ],
                      color: Colors.yellow,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_downward),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_left),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_upward),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

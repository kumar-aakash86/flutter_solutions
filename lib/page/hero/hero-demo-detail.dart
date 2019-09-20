import 'package:flutter/material.dart';

class HeroDemoDetail extends StatefulWidget {
  @override
  _HeroDemoDetailState createState() => _HeroDemoDetailState();
}

class _HeroDemoDetailState extends State<HeroDemoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            pinned: true,
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_left),
            //   onPressed: () => Navigator.pop(context),
            // ),
            expandedHeight: 300.0,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(
              children: <Widget>[
                Hero(
                    tag: 1,
                    child: Image.asset("assets/user.png", fit: BoxFit.cover,)
                    ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Material(
                    color: Colors.transparent,
                    child: Chip(
                      backgroundColor: Colors.blue,
                      labelStyle: TextStyle(color: Colors.white),
                      label: Text("Test"),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Material(
                    color: Colors.transparent,
                    child: Chip(
                      backgroundColor: Colors.blue,
                      labelStyle: TextStyle(color: Colors.white),
                      label: Text("2 Berita"),
                    ),
                  ),
                ),
              ],
            )),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () => "",
              ),
            ],
          ),
          SliverFillRemaining(
            child: Container(
              color: Colors.redAccent,
            ),
          )
        ],
      ),
    );
  }
}

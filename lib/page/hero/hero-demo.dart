import 'package:flutter/material.dart';

import 'hero-demo-detail.dart';

class HeroDemo extends StatefulWidget {
  @override
  _HeroDemoState createState() => _HeroDemoState();
}

class _HeroDemoState extends State<HeroDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: 
          // InkWell(
          //   child: Hero(
          //     tag: 1,
          //           // CircleAvatar(
          //           //   backgroundColor: Colors.red,
          //           //   radius: 50,
          //           //   backgroundImage:
          //           //       AssetImage("assets/user.png"),
          //           // ),
          //   ),
          //   onTap: () => Navigator.of(context).push(
          //       MaterialPageRoute(builder: (context) => HeroDemoDetail())),
          // )
          Hero(
            tag: 1,
            child: Material(
              color: Colors.red,
                          child: InkWell(
                            
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  HeroDemoDetail())),
                      child:
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 50,
                        backgroundImage:
                            AssetImage("assets/user.png"),
                      ),
                    ),
            ),
          ),
          ),
    );
  }
}

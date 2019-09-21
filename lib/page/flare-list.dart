import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';

class FlareList extends StatefulWidget {
  @override
  _FlareListState createState() => _FlareListState();
}

class _FlareListState extends State<FlareList> {
  FlareController _penguin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.red,
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 200,
            delegate: SliverChildListDelegate([
              FlareActor("assets/flare/Teddy.flr",
                      alignment: Alignment.center,
                      isPaused: false,
                      fit: BoxFit.contain,
                      animation: "hands_up",
                      controller: _penguin),
              FlareActor("assets/flare/Penguin.flr",
                      alignment: Alignment.center,
                      isPaused: false,
                      fit: BoxFit.fill,
                      animation: "walk",
                      controller: _penguin),
              FlareActor("assets/flare/Favorite.flr",
                      alignment: Alignment.center,
                      isPaused: false,
                      fit: BoxFit.none,
                      animation: "Favorite",
                      controller: _penguin),
              FlareActor("assets/flare/Penguin.flr",
                      alignment: Alignment.center,
                      isPaused: false,
                      fit: BoxFit.fill,
                      animation: "walk",
                      controller: _penguin),
              FlareActor("assets/flare/Favorite.flr",
                      alignment: Alignment.center,
                      isPaused: false,
                      fit: BoxFit.none,
                      animation: "Favorite",
                      controller: _penguin),
              FlareActor("assets/flare/Penguin.flr",
                      alignment: Alignment.center,
                      isPaused: false,
                      fit: BoxFit.fill,
                      animation: "walk",
                      controller: _penguin),
              FlareActor("assets/flare/Favorite.flr",
                      alignment: Alignment.center,
                      isPaused: false,
                      fit: BoxFit.none,
                      animation: "Favorite",
                      controller: _penguin),
              FlareActor("assets/flare/Penguin.flr",
                      alignment: Alignment.center,
                      isPaused: false,
                      fit: BoxFit.fill,
                      animation: "walk",
                      controller: _penguin),
              FlareActor("assets/flare/Favorite.flr",
                      alignment: Alignment.center,
                      isPaused: false,
                      fit: BoxFit.none,
                      animation: "Favorite",
                      controller: _penguin),
            ]),
          )
        ],
      ),
    );
  }
}

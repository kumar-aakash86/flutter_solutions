import 'package:flutter/material.dart';

class MultiList extends StatefulWidget {
  @override
  _MultiListState createState() => _MultiListState();
}

class _MultiListState extends State<MultiList> with SingleTickerProviderStateMixin {
  
  ScrollController hController;
  ScrollController tController;
  ScrollController fController;
  ScrollController bController;

  @override
  void initState() {
    super.initState();
    hController = new ScrollController()..addListener(_scrollListener);
    tController = new ScrollController()..addListener(_scrollListener);
    fController = new ScrollController()..addListener(_scrollListener);
    bController = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    hController.removeListener(_scrollListener);
    tController.removeListener(_scrollListener);
    fController.removeListener(_scrollListener);
    bController.removeListener(_scrollListener);
  }
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 4,
        child: new Scaffold(
          //Removed AppBar for readability
          body: new TabBarView(
            children: [
              new Container(// hot
                child: ListView(
                    controller: hController,
                    children: getChilds("hot"),
                ),
              ),
              new Container( //Trending
                child: ListView(
                  controller: tController,
                  children: getChilds("trending"),
                ),
              ),
              new Container( //Fresh
                child: ListView(
                  controller: fController,
                  children: getChilds("fresh"),
                ),
              ),
              new Container( //Best
                child: ListView(
                  controller: bController,
                  children: getChilds("best"),
                ),
              ),
            ],
          ),
        ));
  }
  void _scrollListener() {
    if (hController.positions.length > 0 && hController.position.extentAfter == 0.0) {
      print('hController');
      // setState(() {
      //   getChilds("hot");
      // });
    }else if (tController.positions.length > 0 && tController.position.extentAfter == 0.0) {
      // setState(() {
      //   getChilds("trending");
      // });
      print('tController');
    } else if (fController.positions.length > 0 &&fController.position.extentAfter == 0.0) {
      // setState(() {
      //   getChilds("fresh");
      // });
      print('fController');
    } else if (bController.positions.length > 0 &&bController.position.extentAfter == 0.0) {
      // setState(() {
      //   getChilds("best");
      // });
      print('fController');
    }
  }

  getChilds(String name){
    List<Widget> list = new List();
    for(int i=1; i<=20; i++){
      list.add(Card(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Center(child: Text(name+" "+i.toString(),),
        ),
      )));
    }
    return list;
  }
}
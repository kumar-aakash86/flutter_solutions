import 'package:flutter/material.dart';

class TabDemo extends StatefulWidget {
  @override
  _TabDemoState createState() => _TabDemoState();
}

class _TabDemoState extends State<TabDemo> with SingleTickerProviderStateMixin {
  TabController _tabController;

  int _selectedTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(vsync: this, length: 3);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tab Demo"),
      ),
      backgroundColor: Colors.white,
      body: DefaultTabController(
          // The number of tabs / content sections to display.
          length: 3,
          child: Column(
            children: <Widget>[
              Material(
                color: Colors.white,
                child: TabBar(
                  unselectedLabelColor: Colors.blue,
                  labelColor: Colors.blue,
                  indicatorColor: Colors.white,
                  controller: _tabController,
                  labelPadding: const EdgeInsets.all(0.0),

                  // labelColor: Colors.black,
                  // // indicatorColor: Colors.black,
                  // indicatorSize: TabBarIndicatorSize.label,
                  // indicatorWeight: 2.0,
                  // indicatorPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  // indicator: ShapeDecoration(
                  //   shape: MyShape()
                  //     // UnderlineInputBorder(
                  //     //   borderSide: BorderSide(width: 8.0),
                  //     //   borderRadius: BorderRadius.only(
                  //     //     topLeft: Radius.elliptical(50, 360),
                  //     //     topRight: Radius.elliptical(50, 360),
                  //     //     // bottomLeft: Radius.elliptical(50, 360),
                  //     //     // bottomRight: Radius.elliptical(50, 360),
                  //     //   ),
                  //     // ),
                  //     ),
                  tabs: [
                    _getTab(0, Icon(Icons.directions_car)),
                    _getTab(1, Icon(Icons.directions_transit)),
                    _getTab(2, Icon(Icons.directions_bike)),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Icon(Icons.directions_car),
                    Icon(Icons.directions_transit),
                    Icon(Icons.directions_bike),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  _getTab(index, child) {
    return Tab(
      child: SizedBox.expand(
        child: Container(
          child: child,
          decoration: BoxDecoration(
              color:
                  (_selectedTab == index ? Colors.white : Colors.grey.shade300),
              borderRadius: _generateBorderRadius(index)),
        ),
      ),
    );
  }

  _generateBorderRadius(index) {
    if ((index + 1) == _selectedTab)
      return BorderRadius.only(bottomRight: Radius.circular(10.0));
    else if ((index - 1) == _selectedTab)
      return BorderRadius.only(bottomLeft: Radius.circular(10.0));
    else
      return BorderRadius.zero;
  }
}

class MyShape extends ShapeBorder {
  int shapeDistance = 5;
  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getInnerPath
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getOuterPath
    return null;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    final paint = Paint();
    Path path = new Path();
    path.moveTo(rect.bottomLeft.dx + shapeDistance, rect.bottomLeft.dy);
    path.lineTo(rect.bottomLeft.dx, rect.bottomLeft.dy + shapeDistance);
    path.lineTo(rect.bottomRight.dx, rect.bottomRight.dy + shapeDistance);
    path.lineTo(rect.bottomRight.dx - shapeDistance, rect.bottomRight.dy);
    canvas.drawPath(path, paint);
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    return null;
  }
}

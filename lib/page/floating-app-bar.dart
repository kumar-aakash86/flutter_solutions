import 'package:flutter/material.dart';

class FloatingAppBarDemo extends StatefulWidget {
  @override
  _FloatingAppBarDemoState createState() => _FloatingAppBarDemoState();
}

class _FloatingAppBarDemoState extends State<FloatingAppBarDemo> {
  ScrollController scrollController;
  final double expandedHight = 150.0;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  double get top {
    double res = expandedHight;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      if (offset < (res - kToolbarHeight)) {
        res -= offset;
      } else {
        res = kToolbarHeight;
      }
    }
    return res;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _cardPaginator(),
      ),
    );
  }

  _body() {
    return NestedScrollView(
      controller: scrollController,
      headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 200,
            centerTitle: true,
            pinned: true,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
                          child: Image.asset("assets/user.png"),
                          maxRadius: 80,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ];
      },
      body: Column(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 100),
            height: top,
            color: Colors.blue,
            child: Center(
              child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade400,
                    child: Image.asset("assets/user.png"),
                    maxRadius: 80,
                  )),
            ),
          ),
          Container(
            color: Colors.red,
            height: 500,
          )
        ],
      ),
    );
  }

  _cardPaginator() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white,
          expandedHeight: 200,
          centerTitle: true,
          pinned: true,
          elevation: 0,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade400,
                        child: Image.asset("assets/user.png"),
                        maxRadius: 80,
                      )),
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("Aakash Kumar", style: Theme.of(context).textTheme.headline,)),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildListDelegate(
            [
              Container(color: Colors.red),
              Container(color: Colors.purple),
              Container(color: Colors.green),
              Container(color: Colors.orange),
              Container(color: Colors.yellow),
              Container(color: Colors.pink),
            ],
          ),
        ),
      ],
    );
  }

  _cardPaginator2() {
    return Stack(
      children: [
        NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200,
                flexibleSpace:
                    // Stack(
                    //   children: <Widget>[
                    //    Center(
                    //         child: Container(
                    //             padding: const EdgeInsets.all(10.0),
                    //             child: CircleAvatar(
                    //               backgroundColor: Colors.grey.shade400,
                    //               child: Image.asset("assets/user.png"),
                    //               maxRadius: 80,
                    //             )),
                    //       ),
                    //       Positioned(
                    //         bottom: 0,
                    //         left: 0,
                    //         right: 0,
                    //         child: Center(child: Text("Aakash Kumar")),
                    //       ),
                    //   ],
                    // ),
                    ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade400,
                            child: Image.asset("assets/user.png"),
                            maxRadius: 80,
                          )),
                    ),
                    Container(
                      color: Colors.blue,
                      height: 100,
                      alignment: Alignment.center,
                      child: RaisedButton(
                        color: Colors.red,
                        child: Text('folow adfad adf adf safdadfa a da'),
                        onPressed: () => print('folow pressed'),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 80,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                'text_string'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
        // Positioned(
        //   top: top,
        //   width: MediaQuery.of(context).size.width,
        //   child: Align(
        //     child: RaisedButton(
        //       onPressed: () => print('shuffle pressed'),
        //       child: Text('Suffle'),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  _userUI() {
    return Stack(
      children: [
        Positioned(
          top: 20.0,
          left: 20.0,
          child: GestureDetector(
            // onTap should run while the text is visible on the screen
            // The text will become invisible when the Listview gest scrolled upwards
            onTap: () {
              print('text tapped');
            },
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.blueAccent,
              // This is fixed Text over which the card should scroll
              child: Text('Test Button'),
            ),
          ),
        ),
        ListView(children: [
          //  This margin in first empty container pushes the whole card downward and makes the 'Test Button visible'
          Container(margin: EdgeInsets.only(top: 50.0)),
          // This is where the scrolling card actually starts
          Container(color: Colors.cyan[100], height: 120.0, width: 20.0),
          Container(color: Colors.cyan, height: 120.0, width: 20.0),
          Container(color: Colors.cyan[100], height: 120.0, width: 20.0),
          Container(color: Colors.cyan, height: 120.0, width: 20.0),
          Container(color: Colors.cyan[100], height: 120.0, width: 20.0),
          Container(color: Colors.cyan, height: 120.0, width: 20.0),
        ])
      ],
    );
  }
}

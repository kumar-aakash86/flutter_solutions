import 'package:demo1/page/base64-image.dart';
import 'package:demo1/page/bottom-container.dart';
import 'package:demo1/page/expandable-demo.dart';
import 'package:demo1/page/flare-list.dart';
import 'package:demo1/page/floating-app-bar.dart';
import 'package:demo1/page/form-demo.dart';
import 'package:demo1/page/hero/hero-demo.dart';
import 'package:demo1/page/list-demo.dart';
import 'package:demo1/page/list-vs-column.dart';
import 'package:demo1/page/modal-demo.dart';
import 'package:demo1/page/orientation/orientation-demo.dart';
import 'package:demo1/page/particle-demo.dart';
import 'package:demo1/page/tab-demo.dart';
import 'package:demo1/page/webview-demo.dart';
import 'package:demo1/page/will-popup.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ListModel> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    list = new List();
    list.add(ListModel("Base64 Image", BaseImageDemo()));
    list.add(ListModel("List with Card", ListDemo()));
    list.add(ListModel("Explandable", ExpandableDemo()));
    list.add(ListModel("List Vs Column", ListVsColumnDemo()));
    list.add(ListModel("Tab Demo", TabDemo()));
    list.add(ListModel("Particle Demo", ParticleDemo()));
    // list.add(ListModel("Weather Demo", WeatherDemo()));
    list.add(ListModel("Tap Issue Demo", FloatingAppBarDemo()));
    list.add(ListModel("Will Popup Demo", WillPopupDemo()));
    list.add(ListModel("Form Demo", FormDemo()));
    list.add(ListModel("Modal Demo", ModalDemo()));
    list.add(ListModel("WebView Demo", WebViewDemo()));
    list.add(ListModel("Hero Demo", HeroDemo()));
    list.add(ListModel("Orientation Demo", OrientationDemo()));
    list.add(ListModel("Bottom Container Demo", BottomContainer()));
    list.add(ListModel("Flare List Demo", FlareList()));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.separated(
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
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Aakash"),
                accountEmail: Text("test@test.com"),
                currentAccountPicture: CircleAvatar(
                  child: Text("A"),
                ),
              ),
              ListTile(
                title: Text("Help"),
                leading: Icon(Icons.help),
              ),
              ListTile(
                title: Text("Login"),
                leading: Icon(Icons.lock),
              )
            ],
          ),
        ),
        );
  }
}

class ListModel {
  String title;
  Widget page;

  ListModel(this.title, this.page);
}

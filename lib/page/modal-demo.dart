import 'package:flutter/material.dart';

class ModalDemo extends StatefulWidget {
  @override
  _ModalDemoState createState() => _ModalDemoState();
}

class _ModalDemoState extends State<ModalDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("Modal Demo"),
          onPressed: _showDialog,
        ),
      ),
    );
  }

  _showDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(12.0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Title", style: Theme.of(context).textTheme.title),
                    // IconButton(padding: const EdgeInsets.all(0), alignment: Alignment(1, 0), onPressed: () => Navigator.pop(context), icon: Icon(Icons.clear))
                    InkWell(
                      child: Icon(Icons.clear),
                      onTap: () => Navigator.pop(context),
                    ),
                    // )
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0),
                //   child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam viverra eros vitae neque faucibus ullamcorper. Nam lobortis hendrerit est vel malesuada. Fusce sem nisi, luctus sit amet nunc at, tempor ullamcorper leo. Donec tempor erat eget vehicula cursus. Nulla fringilla vestibulum libero. Maecenas viverra rhoncus urna ut aliquet. Donec rutrum viverra pulvinar. Nulla tempus mollis elementum. Quisque a cursus tellus, id finibus leo. Nulla facilisi. Nunc eget nibh id turpis commodo tincidunt."),
                // )
                Container(
                  height: 150,
                  child: ListView(
                  itemExtent: 50.0,
                  children: <Widget>[
                    Text("Text 1"),
                    Text("Text 1"),
                    Text("Text 1"),
                    Text("Text 1"),
                    Text("Text 1"),
                    Text("Text 1"),
                    Text("Text 1"),
                    Text("Text 1"),
                  ],
                ),
                )
              ],
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';

class WillPopupDemo extends StatefulWidget {
  @override
  _WillPopupDemoState createState() => _WillPopupDemoState();
}

class _WillPopupDemoState extends State<WillPopupDemo> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _showDialog,
      child: Scaffold(
        body: Center(
          child: Text("This is the first page"),
        ),
      ),
    );
  }

  Future<bool> _showDialog() {
    return showDialog(
      context: context,
      builder: (context) {
      return AlertDialog(
        title: Text("Are you sure?"),
        content: Text("You want to exit app"),
        actions: <Widget>[
          FlatButton(
            child: Text("Yes"),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          FlatButton(
            child: Text("No"),
            onPressed: () => Navigator.of(context).pop(false),
          )
        ],
      );
    }) ?? false;
  }
}

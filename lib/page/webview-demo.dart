import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'form-demo.dart';

class WebViewDemo extends StatefulWidget {
  @override
  _WebViewDemoState createState() => _WebViewDemoState();
}

class _WebViewDemoState extends State<WebViewDemo> {
  bool _showWebView = true;
  var flutterWebviewPlugin;

  String myHtml =
      '<p style="margin-left: 30px;">Read <a style= "text-decoration: none;"  href="navigate:Page_two">Prohibited ads1</a></p>';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Load WebView"),
      ),
      body: _showWebView ? _getWebView() : Container(),
    );
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  _getWebView() {
    setupListener();
    return WebviewScaffold(
      withJavascript: true,
      appCacheEnabled: true,
      url: new Uri.dataFromString(myHtml, mimeType: 'text/html', encoding: utf8)
          .toString(),
    );
  }

  setupListener() {
    flutterWebviewPlugin = new FlutterWebviewPlugin();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url.startsWith("navigate:")) {
        final page = url.substring(url.indexOf(":") + 1, url.length);
        Widget widget = null;
        setState(() {
          _showWebView = false;
        });
        switch (page) {
          case 'Page_two':
            widget = FormDemo();
            break;
        }
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget))
            .then((value) {
          setState(() {
            _showWebView = true;
          });
        });
        flutterWebviewPlugin.close();
      }
    });
  }
}

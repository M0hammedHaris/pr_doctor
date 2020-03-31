import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebBrowser extends StatefulWidget {
  final String url;
  WebBrowser({Key key, this.url}) : super(key: key);

  @override
  _WebBrowserState createState() => _WebBrowserState();
}

class _WebBrowserState extends State<WebBrowser> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(),
      url: widget.url,
      withZoom: false,
    );
  }
}
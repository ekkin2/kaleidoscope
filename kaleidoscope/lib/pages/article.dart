import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/*
 * This page will be used to view the article using a Flutter
 * WebView.
 */
class ArticlePage extends StatefulWidget {
  ArticlePage({Key key, this.url}) : super(key: key);
  final String url;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Widget _buildAppBar() {
    return new AppBar(
      // title: Text("Web Page"),
      leading: IconTheme(
        data: IconThemeData(color: Colors.white),
        child: BackButton(),
      ),
      actions: <Widget>[
      ],
    );
  }

  Widget _articleWeb(url) {
    return WebView(
      initialUrl: url,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _articleWeb('https://www.flutter.dev'),

    );
  }
}
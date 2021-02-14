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
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconTheme(
        data: IconThemeData(color: Colors.white),
        child: BackButton(color: Colors.black87,),
      ),
      actions: <Widget>[
      ],
      title: Hero(
        tag: 'logo',
        child: Container(
          margin: EdgeInsets.all(8),
          child: SizedBox(
            height: 42,
            child: Image(image: AssetImage('assets/images/kaleidoscope_logo.png')),
          ),
        ),
      ),
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
      body: _articleWeb(widget.url),

    );
  }
}
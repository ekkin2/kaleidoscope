import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/*
 * This page will be used to view the article using a Flutter
 * WebView.
 */
class ArticlePage extends StatefulWidget {
  ArticlePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  String _tempUrl = 'https://www.google.com';

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Widget _articleWeb(url) {
    return WebView(
      initialUrl: url,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _articleWeb(_tempUrl);
  }
}
import 'package:flutter/material.dart';

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

  Widget _feedListView() {
    return ListView(
      children: [
        Card(
          child: Text("hello world"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // todo: add webview
        child: _feedListView(),
      ),
    );
  }
}
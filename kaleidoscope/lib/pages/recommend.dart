import 'package:flutter/material.dart';

class RecommendPage extends StatefulWidget {
  RecommendPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {

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
        child: _feedListView(),
      ),
    );
  }
}
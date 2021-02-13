import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:kaleidoscope/services/models/news_model.dart';
import 'package:kaleidoscope/widgets/news_card.dart';

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
        NewsCard(),
        NewsCard(),
        NewsCard(),
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
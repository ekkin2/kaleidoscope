import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:kaleidoscope/services/models/news_model.dart';
import 'package:kaleidoscope/widgets/news_card.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  String _sortDropdownValue = "Recent";

  Widget _dropdown(List<String> items, List onTaps) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      width: 136,
      height: 36,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: DropdownButtonHideUnderline(
          child: Container(
            margin: EdgeInsets.only(left: 16),
            child: DropdownButton(
              value: _sortDropdownValue,
              items: ['Recent', 'Objective'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );
  }

  Widget _filter() {
    return Container(
      // color: Colors.white,
      height: 24,
      child: Row(
        children: [
          Expanded(child: _dropdown([], [])),
          Expanded(child: _dropdown([], [])),
        ],
      ),
    );
  }

  Widget _feedListView() {
    return ListView(
      children: [
        NewsCard(),
        NewsCard(),
      ],
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(flex: 1, child: _filter()),
        Expanded(flex: 9, child: _feedListView()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _body(),
      ),
    );
  }
}
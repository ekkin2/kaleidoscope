import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:kaleidoscope/services/models/news_model.dart';
import 'package:kaleidoscope/widgets/news_card.dart';

import 'package:kaleidoscope/services/network.dart';
import 'package:kaleidoscope/services/models/news_model.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  Future<List<News>> futureFeed;
  String _sortDropdownValue = "Recent";
  String _topicDropdownValue = "General";

  @override
  void initState() {
    super.initState();
    futureFeed = fetchNews(_sortDropdownValue, _topicDropdownValue);
  }

  Widget _dropdown(List<String> items, void Function(String) onChanged, String value) {
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
              value: value,
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged
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
          Expanded(
              child: _dropdown(
                  ["Recent", "Objective"],
                  (String newValue) {
                    setState(() {
                      _sortDropdownValue = newValue;
                    });
                    _onRefresh();
                  },
                  _sortDropdownValue)),
          Expanded(
              child: _dropdown(
                  ["Business", "Entertainment", "General", "Health", "Science", "Sports", "Technology"],
                  (String newValue) {
                    setState(() {
                      _topicDropdownValue = newValue;
                    });
                    _onRefresh();
                  },
                  _topicDropdownValue)),
        ],
      ),
    );
  }

  Future _onRefresh() async {
    setState(() {
      futureFeed = fetchNews(_sortDropdownValue, _topicDropdownValue);
    });
  }

  Widget _futureFeed() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: FutureBuilder<List<News>>(
        future: futureFeed,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return NewsCard(
                    // todo: input news into here
                    news: snapshot.data[index],
                  );
                }
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }

  // This widget is the list view of news cards
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
        Expanded(flex: 9, child: _futureFeed()),
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
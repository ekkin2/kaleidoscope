import 'package:flutter/material.dart';

import 'package:kaleidoscope/services/models/news_model.dart';

class NewsCard extends StatefulWidget {
  // NewsCard({Key key, this.news}) : super(key: key);
  // final News news;

  NewsCard({Key key}) : super(key: key);
  // todo: add news param back

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {

  Widget _metricColumn() {
    return Column(
      // todo: add polarity meter here

      // todo: add objectivity meter here
    );
  }

  Widget _layout() {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              // todo: add thumnail here
              _metricColumn(),
            ],
          ),
          // todo: add source img here
          Text('Source Here'),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Text('Title'),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () => {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _layout(),
    );
  }
}
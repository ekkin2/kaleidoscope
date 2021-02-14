import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:kaleidoscope/pages/article.dart';
import 'package:kaleidoscope/services/models/news_model.dart';
import 'package:kaleidoscope/util/gradient.dart';
import 'package:kaleidoscope/util/colors.dart';

class NewsCard extends StatefulWidget {
  NewsCard({Key key, this.news}) : super(key: key);
  final News news;

  // NewsCard({Key key}) : super(key: key);
  // todo: add news param back

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {

  String _bullet = "\u2022";
  String _tempImgLink = "https://media.discordapp.net/attachments/809916337551966259/810003668057194496/12oszyW4ja3z9-VLfTjBwFA.png?width=705&height=397";
  String _tempSourceLink = "https://cdn.discordapp.com/attachments/809916337551966259/810005502502371348/CNN-Logo.png";
  List<String> _tempFactsList = ["fact 1 sdfskdfjlskdfjlskdfjlskdfjlskdfjlskdjfls lsdlskdflskd fkd fdk fkdf dk fkd fkd fkdfs kdf s", "fact 2", "fact 3"];

  int _objectivity;

  @override
  void initState() {
    _objectivity = (widget.news.objectivity / 20).ceil();
  }

  Widget _thumbnail(String imageLink) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 4.5,
              child: Container(
                margin: EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    imageLink,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _polarityMeter(double value) {
    return Tooltip(
      message: "Polarity",
      child: AbsorbPointer(
        child: SliderTheme(
            data: SliderThemeData(
              thumbColor: colfunc(value, 0, 100, Colors.blue, Colors.red),
              // disabledThumbColor: ,
              trackShape: GradientRectSliderTrackShape(gradient: gradient, darkenInactive: false),
            ),
            child: Slider(
              min: 0,
              max: 100,
              value: value,
              onChanged: (value) => {},
            )
        ),
      ),
    );
  }

  Widget _source(sourceLink) {
    return Container(
      margin: EdgeInsets.only(left: 12, bottom: 4, top: 8),
      child: Image.network(
        sourceLink,
        height: 20,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _objectivityMeter() {
    return Tooltip( // Objectivity Ranking
      message: "Objectivity",
      child: Row(
        children: [
          for (int i = 0; i < _objectivity; i++) Icon(Icons.star, color: Colors.amber, ),
          for (int i = 0; i < 5 - _objectivity; i++) Icon(Icons.star_border),
        ],
      ),
    );
  }

  Widget _title(String title) {
    return Container(
        margin: EdgeInsets.only(left: 12, top: 8, right: 8),
        child: Text(
            title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
  }

  Widget _timestamp(String time) {
    return Container(
        margin: EdgeInsets.only(top: 8, bottom: 8, left: 12),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
    );
  }

  Widget _factsButton() {
    return Container(
        margin: EdgeInsets.only(right: 8),
        child: ExpandableButton(
          child: Icon(
              Icons.list,
            size: 28,
          ),
        ),
      );
  }

  Widget _bottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(widget.news.title),
              _timestamp(widget.news.timestamp),
            ],
          ),
        ),
        _factsButton(),
      ],
    );
  }

  Widget _factsList(List factsList) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i in factsList) Row(
            children: [
              Text(
                  _bullet + ' ',
                style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
              ),
              Text(
                i,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16
                ),
              )
            ],
          ),
        ],
      ),
    );
  }


  Widget _layout() {
    return ExpandableNotifier(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //
            //     _metricColumn(0.5),
            //   ],
            // ),

            _thumbnail(widget.news.imageLink),
            _polarityMeter(widget.news.polarity.toDouble()),
            IntrinsicHeight(
              child: Row(
                children: [
                  _source(_tempSourceLink),
                  // Padding(padding: EdgeInsets.all(12),),
                  VerticalDivider(width: 36, thickness: 2, indent: 6, endIndent: 2, ),
                  _objectivityMeter(),
                ],
              ),
            ),

            Expandable(
              collapsed: _bottomRow(),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bottomRow(),
                  _factsList(widget.news.facts),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),

      child: Container(
        margin: EdgeInsets.all(8),
        child: _layout(),
      ),
    );
  }

  String _tempUrl = "https://www.npr.org/sections/trump-impeachment-trial-live-updates/2021/02/12/967425820/trump-defense-tries-to-switch-blame-saying-democrats-didnt-condemn-looting";
  // on taps
  _onTap(context){
    // todo: change url to widget.news.url
    // todo: whenever tapped, add polarity of news source to global moving avg.
    // todo: global avg. can be a global var
    Navigator.of(context).push(new ArticlePageRoute(widget.news.link));
  }
}

class ArticlePageRoute extends MaterialPageRoute {
  ArticlePageRoute(String url)
      : super(
    builder:
        (BuildContext context) => new ArticlePage(
        url: url,
    ),
    fullscreenDialog: true,
  );
}

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:kaleidoscope/pages/article.dart';
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

  String _bullet = "\u2023 ";
  String _tempImgLink = "https://media.discordapp.net/attachments/809916337551966259/810003668057194496/12oszyW4ja3z9-VLfTjBwFA.png?width=705&height=397";
  String _tempSourceLink = "https://cdn.discordapp.com/attachments/809916337551966259/810005502502371348/CNN-Logo.png";
  List<String> _tempFactsList = ["fact 1 sdfskdfjlskdfjlskdfjlskdfjlskdfjlskdjfls lsdlskdflskd fkd fdk fkdf dk fkd fkd fkdfs kdf s", "fact 2", "fact 3"];

  Widget _thumbnail(String imageLink) {
    return Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            _tempImgLink,
            fit: BoxFit.cover,
          ),
        ), 
      ),
    );
  }

  Widget _polarityMeter() {
    return Container(
      height: 70,
      child: SfRadialGauge(
        axes: <RadialAxis>[RadialAxis(
            showLabels: false,
          showTicks: false,
          pointers: [NeedlePointer(value: 90, needleStartWidth: 1, needleEndWidth: 3)],
          axisLineStyle: AxisLineStyle(
            gradient: SweepGradient(
                colors: [Colors.blue, Colors.red],
              stops: [0.25, 0.75],
            ),
          ),
        )
        ],
      ),
    );
  }

  Widget _objectivityMeter(percent) {
    return Container(
      height: 70,
      child: SfRadialGauge(
        axes: <RadialAxis>[RadialAxis(
          showLabels: false,
          showTicks: false,
          // pointers: [NeedlePointer(value: 90, needleStartWidth: 1, needleEndWidth: 3)],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(axisValue: 50, positionFactor: 0.2,
                widget: Text((percent*100).round().toString(), style:
                TextStyle(fontWeight: FontWeight.w300, fontSize: 20),))],
          ranges: <GaugeRange>[GaugeRange(startValue: 0, endValue: percent*100, color: Colors.green,
          )],
          // axisLineStyle: AxisLineStyle(
          //   gradient: SweepGradient(
          //     colors: [Colors.blue, Colors.red],
          //     stops: [0.25, 0.75],
          //   ),
          // ),
        )
        ],
      ),
    );
  }

  Widget _metricColumn(percent) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Tooltip(
              message: 'Polarity',
              child: _polarityMeter(),
            ),
            Tooltip(
              message: 'Objectivity',
              child: _objectivityMeter(.65),
            ),
          ],
        ),
      ),
    );
  }

  Widget _source() {
    return Container(
      margin: EdgeInsets.only(left: 12, bottom: 4, top: 8),
      child: Image.network(
        _tempSourceLink,
        height: 16,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _title() {
    return Container(
        margin: EdgeInsets.only(left: 12, top: 8, right: 8),
        child: Text(
            "Microsoft's Big Win in Quantum Computing Was an 'Error' After All",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
  }

  Widget _timestamp() {
    return Container(
        margin: EdgeInsets.only(top: 8, bottom: 8, left: 12),
        child: Text(
          'Yesterday',
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
          child: Icon(Icons.list),
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
              _title(),
              _timestamp(),
            ],
          ),
        ),
        _factsButton(),
      ],
    );
  }

  Widget _factsList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i in _tempFactsList) Text(
            _bullet + i,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16
            ),
          )
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
            Row(
              children: [
                _thumbnail(_tempImgLink),
                _metricColumn(0.5),
              ],
            ),
            // todo: add source img here
            _source(),

            Expandable(
              collapsed: _bottomRow(),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bottomRow(),
                  _factsList(),
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
    Navigator.of(context).push(new ArticlePageRoute(_tempUrl));
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

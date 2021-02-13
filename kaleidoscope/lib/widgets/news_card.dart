import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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

  String _tempImgLink = "https://media.discordapp.net/attachments/809916337551966259/810003668057194496/12oszyW4ja3z9-VLfTjBwFA.png?width=705&height=397";
  String _tempSourceLink = "https://cdn.discordapp.com/attachments/809916337551966259/810005502502371348/CNN-Logo.png";

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

  Widget _metricColumn() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            _polarityMeter(),
             //todo: polarity meter
            CircularPercentIndicator(radius: 64, percent: .50, ), //todo: objectivity meter
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
        child: IconButton(
          icon: Icon(Icons.list),
          onPressed: () => {},
        ),
      );
  }

  Widget _layout() {
    return Card(
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
              _metricColumn(),
            ],
          ),
          // todo: add source img here
          _source(),

          Row(
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
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: _layout(),
    );
  }
}
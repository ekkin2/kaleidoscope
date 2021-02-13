import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:kaleidoscope/services/models/news_model.dart';
import 'package:kaleidoscope/widgets/news_card.dart';

class RecommendPage extends StatefulWidget {
  RecommendPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {

  Widget _polarityMeter() {
    return Container(
      height: 70,
      child: SfRadialGauge(
        axes: <RadialAxis>[RadialAxis(
          showLabels: false,
          showTicks: false,
          pointers: [NeedlePointer(value: 30, needleStartWidth: 1, needleEndWidth: 3)],
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

  // This widget is a text widget that notifies the user
  // about their reading habits
  Widget _notification() {
    return Container(
      child: Row(
        children: [
          Expanded(child:
            Container(
              margin: EdgeInsets.all(12),
              child: _polarityMeter(),
            ),
          ),

          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: Text("You've been reading more liberal articles recently.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _feedListView() {
    return ListView(
      children: [
        NewsCard(),
        NewsCard(),
        NewsCard(),
      ],
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(flex: 1, child: _notification()),
        Expanded(flex: 9, child:_feedListView()),
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
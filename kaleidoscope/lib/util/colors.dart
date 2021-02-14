import 'package:flutter/material.dart';

Color colfunc(double val, double minval, maxval, Color startcolor, Color stopcolor) {
  double f = (val - minval) / (maxval - minval);

  List<List<double>> colors = [];
  colors.add([startcolor.red.toDouble(), stopcolor.red.toDouble()]);
  colors.add([startcolor.green.toDouble(), stopcolor.green.toDouble()]);
  colors.add([startcolor.blue.toDouble(), stopcolor.blue.toDouble()]);

  List<double> color = [];
  for (int i = 0; i < colors.length; i++) {
    double a = colors[i][0];
    double b = colors[i][1];

    double val = f * (b - a) + a;
    color.add(val);
  }
  return Color.fromRGBO(color[0].round(), color[1].round(), color[2].round(), 1);
}
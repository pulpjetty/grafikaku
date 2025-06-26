import 'package:flutter/material.dart';

List<Offset> midpointCircle(Offset center, Offset pointOnCircle) {
  final points = <Offset>[];
  int xc = center.dx.round();
  int yc = center.dy.round();
  int x1 = pointOnCircle.dx.round();
  int y1 = pointOnCircle.dy.round();
  int r = ((center - pointOnCircle).distance).round();

  int x = 0;
  int y = r;
  int d = 1 - r;

  void plotCirclePoints(int xc, int yc, int x, int y) {
    points.add(Offset((xc + x).toDouble(), (yc + y).toDouble()));
    points.add(Offset((xc - x).toDouble(), (yc + y).toDouble()));
    points.add(Offset((xc + x).toDouble(), (yc - y).toDouble()));
    points.add(Offset((xc - x).toDouble(), (yc - y).toDouble()));
    points.add(Offset((xc + y).toDouble(), (yc + x).toDouble()));
    points.add(Offset((xc - y).toDouble(), (yc + x).toDouble()));
    points.add(Offset((xc + y).toDouble(), (yc - x).toDouble()));
    points.add(Offset((xc - y).toDouble(), (yc - x).toDouble()));
  }

  plotCirclePoints(xc, yc, x, y);
  while (x < y) {
    x++;
    if (d < 0) {
      d += 2 * x + 1;
    } else {
      y--;
      d += 2 * (x - y) + 1;
    }
    plotCirclePoints(xc, yc, x, y);
  }
  return points;
}

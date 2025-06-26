import 'package:flutter/material.dart';

List<Offset> bresenhamLine(Offset p0, Offset p1) {
  final points = <Offset>[];
  int x0 = p0.dx.round();
  int y0 = p0.dy.round();
  int x1 = p1.dx.round();
  int y1 = p1.dy.round();

  int dx = (x1 - x0).abs();
  int dy = (y1 - y0).abs();
  int sx = x0 < x1 ? 1 : -1;
  int sy = y0 < y1 ? 1 : -1;
  int err = dx - dy;

  while (true) {
    points.add(Offset(x0.toDouble(), y0.toDouble()));
    if (x0 == x1 && y0 == y1) break;
    int e2 = 2 * err;
    if (e2 > -dy) {
      err -= dy;
      x0 += sx;
    }
    if (e2 < dx) {
      err += dx;
      y0 += sy;
    }
  }
  return points;
}

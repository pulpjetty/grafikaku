import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../algorithms/line.dart';
import '../algorithms/circle.dart';

class CanvasController extends GetxController {
  // List of points for drawing
  final points = <Offset>[].obs;
  // List of result points for algorithm
  final resultPoints = <Offset>[].obs;

  // Mode: line, circle, polygon
  final mode = 'line'.obs;

  void addPoint(Offset point) {
    if (mode.value == 'line' && points.length >= 2) {
      // Ignore further input until reset
      return;
    }
    if (mode.value == 'circle' && points.length >= 2) {
      // Ignore further input until reset
      return;
    }
    points.add(point);
    if (mode.value == 'line' && points.length == 2) {
      resultPoints.assignAll(bresenhamLine(points[0], points[1]));
    } else if (mode.value == 'circle' && points.length == 2) {
      resultPoints.assignAll(midpointCircle(points[0], points[1]));
    } else if (mode.value == 'polygon' && points.length > 2) {
      resultPoints.assignAll(points);
    } else if (mode.value == 'polygon') {
      resultPoints.clear();
    }
  }

  void clear() {
    points.clear();
    resultPoints.clear();
  }

  void setMode(String newMode) {
    mode.value = newMode;
    clear();
  }

  String get infoHasil {
    if (mode.value == 'line' && points.length == 2) {
      final length = (points[0] - points[1]).distance;
      return 'Panjang garis: ${length.toStringAsFixed(2)} px';
    } else if (mode.value == 'circle' && points.length == 2) {
      final radius = (points[0] - points[1]).distance;
      final keliling = 2 * 3.141592653589793 * radius;
      final luas = 3.141592653589793 * radius * radius;
      return 'Radius: ${radius.toStringAsFixed(2)} px\nKeliling: ${keliling.toStringAsFixed(2)} px\nLuas: ${luas.toStringAsFixed(2)} px²';
    } else if (mode.value == 'polygon' && points.length > 2) {
      double keliling = 0;
      for (int i = 0; i < points.length; i++) {
        final p1 = points[i];
        final p2 = points[(i + 1) % points.length];
        keliling += (p1 - p2).distance;
      }
      // Hitung luas poligon (Shoelace formula)
      double luas = 0;
      for (int i = 0; i < points.length; i++) {
        final p1 = points[i];
        final p2 = points[(i + 1) % points.length];
        luas += (p1.dx * p2.dy) - (p2.dx * p1.dy);
      }
      luas = luas.abs() / 2.0;
      return 'Keliling: ${keliling.toStringAsFixed(2)} px\nLuas: ${luas.toStringAsFixed(2)} px²';
    }
    return '';
  }
}

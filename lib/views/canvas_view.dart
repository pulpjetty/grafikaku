import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/canvas_controller.dart';

class CanvasView extends StatelessWidget {
  CanvasView({super.key});

  final CanvasController controller = Get.put(CanvasController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Canvas Interaktif')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => DropdownButton<String>(
                    value: controller.mode.value,
                    items: const [
                      DropdownMenuItem(value: 'line', child: Text('Garis')),
                      DropdownMenuItem(
                        value: 'circle',
                        child: Text('Lingkaran'),
                      ),
                      DropdownMenuItem(
                        value: 'polygon',
                        child: Text('Poligon'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) controller.setMode(val);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: controller.clear,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTapDown: (details) {
                final RenderBox box = context.findRenderObject() as RenderBox;
                final Offset localPosition = box.globalToLocal(
                  details.globalPosition,
                );
                controller.addPoint(localPosition);
              },
              child: Container(
                color: Colors.grey[200],
                child: Obx(
                  () => CustomPaint(
                    key: ValueKey(controller.resultPoints.length),
                    painter: _CanvasPainter(
                      points: controller.points,
                      mode: controller.mode.value,
                      resultPoints: controller.resultPoints,
                    ),
                    child: Container(),
                  ),
                ),
              ),
            ),
          ),
          // Panel info hasil
          Obx(() {
            final info = controller.infoHasil;
            if (info.isEmpty) return const SizedBox.shrink();
            return Container(
              width: double.infinity,
              color: Colors.grey[100],
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Text(
                info,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _CanvasPainter extends CustomPainter {
  final List<Offset> points;
  final String mode;
  final List<Offset> resultPoints;

  _CanvasPainter({
    required this.points,
    required this.mode,
    required this.resultPoints,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2;

    if (mode == 'line' && resultPoints.isNotEmpty) {
      for (final p in resultPoints) {
        canvas.drawCircle(p, 1.5, paint);
      }
      if (points.length >= 2) {
        final redPaint = Paint()
          ..color = Colors.red
          ..strokeWidth = 2;
        canvas.drawCircle(points[0], 5, redPaint);
        canvas.drawCircle(points[1], 5, redPaint);
        _drawLabel(canvas, points[0], '1');
        _drawLabel(canvas, points[1], '2');
      }
    } else if (mode == 'circle' && resultPoints.isNotEmpty) {
      for (final p in resultPoints) {
        canvas.drawCircle(p, 1.5, paint);
      }
      if (points.length >= 2) {
        final redPaint = Paint()
          ..color = Colors.red
          ..strokeWidth = 2;
        canvas.drawCircle(points[0], 5, redPaint);
        canvas.drawCircle(points[1], 5, redPaint);
        _drawLabel(canvas, points[0], '1');
        _drawLabel(canvas, points[1], '2');
      }
    } else if (mode == 'polygon' && resultPoints.isNotEmpty) {
      // Gambar garis poligon (biru)
      for (int i = 0; i < resultPoints.length - 1; i++) {
        canvas.drawLine(resultPoints[i], resultPoints[i + 1], paint);
      }
      if (resultPoints.length > 2) {
        canvas.drawLine(resultPoints.last, resultPoints.first, paint);
      }
      // Gambar titik-titik poligon (merah)
      for (int i = 0; i < resultPoints.length; i++) {
        final p = resultPoints[i];
        final redPaint = Paint()
          ..color = Colors.red
          ..strokeWidth = 2;
        canvas.drawCircle(p, 5, redPaint);
        _drawLabel(canvas, p, (i + 1).toString());
      }
    }
  }

  void _drawLabel(Canvas canvas, Offset position, String label) {
    final textSpan = TextSpan(
      text: label,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: 30);
    final offset = Offset(position.dx + 8, position.dy - 8);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

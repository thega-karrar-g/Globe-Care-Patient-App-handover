import 'package:flutter/material.dart';

class Drawhorizontalline extends CustomPainter {
  late Paint _paint;
  bool reverse;

  Drawhorizontalline(this.reverse) {
    _paint = Paint()
      ..color = Colors.white30
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (reverse) {
      canvas.drawLine(
          const Offset(-80.0, 0.0), const Offset(-10.0, 0.0), _paint);
    } else {
      canvas.drawLine(const Offset(10.0, 0.0), const Offset(80.0, 0.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

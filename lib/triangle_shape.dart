import 'package:flutter/material.dart';

import 'tile_logic.dart';

class TriangleShape extends StatelessWidget {
  static const size = 20.0;

  final Color color;
  final Corner corner;

  const TriangleShape({
    Key? key,
    required this.color,
    required this.corner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: TrianglePainter(
          fillColor: color,
          corner: corner,
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color fillColor;
  final Corner corner;

  TrianglePainter({
    required this.fillColor,
    required this.corner,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(_getTrianglePath(size.width, size.height), paint);
  }

  Path _getTrianglePath(double x, double y) {
    switch (corner) {
      case Corner.topLeft:
        return Path()
          ..moveTo(0, y)
          ..lineTo(x, 0)
          ..lineTo(x, y)
          ..lineTo(0, y);
      case Corner.topRight:
        return Path()
          ..moveTo(0, 0)
          ..lineTo(x, y)
          ..lineTo(0, y)
          ..lineTo(0, 0);
      case Corner.bottomLeft:
        return Path()
          ..moveTo(0, 0)
          ..lineTo(x, y)
          ..lineTo(x, 0)
          ..lineTo(0, 0);
      case Corner.bottomRight:
        return Path()
          ..moveTo(0, 0)
          ..lineTo(x, 0)
          ..lineTo(0, y)
          ..lineTo(0, 0);
      default:
        return Path();
    }
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return true;
  }
}

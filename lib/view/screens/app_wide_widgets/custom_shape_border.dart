import 'package:flutter/material.dart';

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    const double curveHeight = 50;
    final double x = rect.width;
    final double y = rect.height;

    final path = Path()
      ..lineTo(0, y - curveHeight)
      ..quadraticBezierTo(0, y, curveHeight, y)
      ..lineTo(x - curveHeight, y)
      ..quadraticBezierTo(x, y, x, y - curveHeight)
      ..lineTo(x, 0)
      ..lineTo(0, 0);

    // Add circles
    const double circle1Radius = 20;
    final double circle1X = x - 250;
    const double circle1Y = curveHeight - 150;

    const double circle2Radius = 20;
    final double circle2X = x - 250;
    const double circle2Y = curveHeight - 100;

    path.addOval(Rect.fromCircle(center: Offset(circle1X, circle1Y), radius: circle1Radius));
    path.addOval(Rect.fromCircle(center: Offset(circle2X, circle2Y), radius: circle2Radius));

    return path;
  }
}

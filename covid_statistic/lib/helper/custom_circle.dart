import 'package:covid_statistic/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class CircleOne extends CustomPainter {
  Paint _paint;

  CircleOne() {
    _paint = Paint()
      ..color = Color.fromRGBO(255, 255, 255, 0.17)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(28.0, 0.0), 99.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CircleTwo extends CustomPainter {
  Paint _paint;

  CircleTwo() {
    _paint = Paint()
      ..color = CustomColors.HeaderCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(-30, 20), 50.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
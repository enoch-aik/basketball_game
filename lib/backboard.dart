import 'package:flutter/material.dart';

class BackboardCP extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const Color borderColor = Color(0xffDD6F40);
    Paint smallBoxStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03134796;
    smallBoxStroke.color = borderColor;
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.01567398, size.height * 0.02564103,
            size.width * 0.9686520, size.height * 0.9487179),
        smallBoxStroke);

    Paint smallBox = Paint()..style = PaintingStyle.fill;
    smallBox.color = Colors.white;
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.01567398, size.height * 0.02564103,
            size.width * 0.9686520, size.height * 0.9487179),
        smallBox);

    Paint bigBoxStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.02821317;
    bigBoxStroke.color = borderColor;
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.3385580, size.height * 0.5025641,
            size.width * 0.3260188, size.height * 0.3794872),
        bigBoxStroke);

    Paint bigBox = Paint()..style = PaintingStyle.fill;
    bigBox.color = Colors.white;
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.3385580, size.height * 0.5025641,
            size.width * 0.3260188, size.height * 0.3794872),
        bigBox);
  }

  Matrix4 matrix = Matrix4.identity()..translate(0, 0, -10);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

import 'package:basketball_game/game/basketball_game.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:forge2d/src/dynamics/body.dart';

class BasketBallStandComponent extends BodyComponent {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    add(CustomPainterComponent()
      ..position = Vector2(45, 120)
      ..anchor = Anchor.center
      ..painter = BasketballStandCustomPainter());
  }

  @override
  Body createBody() {
    Shape shape = EdgeShape();
    BodyDef bodyDef = BodyDef(
        position: Vector2(gameRef.size.x / 2, gameRef.size.y),
        type: BodyType.static);
    FixtureDef fixtureDef = FixtureDef(
      shape,
      friction: .4,
      density: 1,
      restitution: .3,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

//Copy this CustomPainter code to the Bottom of the File
class BasketballStandCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(128, 142);
    path_0.lineTo(141, 142);
    path_0.lineTo(141, 496);
    path_0.lineTo(128, 496);
    path_0.lineTo(128, 142);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.black.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(123, 142);
    path_1.cubicTo(123, 139.239, 125.239, 137, 128, 137);
    path_1.lineTo(141, 137);
    path_1.cubicTo(143.761, 137, 146, 139.239, 146, 142);
    path_1.lineTo(146, 496);
    path_1.cubicTo(146, 498.761, 143.761, 501, 141, 501);
    path_1.lineTo(128, 501);
    path_1.cubicTo(125.239, 501, 123, 498.761, 123, 496);
    path_1.lineTo(123, 142);
    path_1.close();
    path_1.moveTo(133, 147);
    path_1.lineTo(133, 491);
    path_1.lineTo(136, 491);
    path_1.lineTo(136, 147);
    path_1.lineTo(133, 147);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = Colors.black.withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(134.768, 2);
    path_2.cubicTo(40.404, 1.99988, 2, 68.6124, 2, 68.6124);
    path_2.lineTo(2, 118.073);
    path_2.lineTo(50.8279, 131.037);
    path_2.lineTo(99.6559, 144);
    path_2.lineTo(134.768, 144);
    path_2.lineTo(169.002, 144);
    path_2.lineTo(217.501, 131.037);
    path_2.lineTo(266, 118.073);
    path_2.lineTo(266, 68.6124);
    path_2.cubicTo(266, 68.6124, 229.132, 2.00012, 134.768, 2);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = const Color(0xffF0C4C4).withOpacity(1.0);
    canvas.drawPath(path_2, paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(3.5, 69.0263);
    path_3.lineTo(3.5, 116.919);
    path_3.lineTo(99.8516, 142.5);
    path_3.lineTo(168.805, 142.5);
    path_3.lineTo(264.5, 116.921);
    path_3.lineTo(264.5, 69.0124);
    path_3.cubicTo(264.44, 68.9101, 264.366, 68.7845, 264.277, 68.6367);
    path_3.cubicTo(263.994, 68.1646, 263.562, 67.4655, 262.977, 66.5717);
    path_3.cubicTo(261.806, 64.784, 260.023, 62.2183, 257.588, 59.1337);
    path_3.cubicTo(252.716, 52.9636, 245.239, 44.7242, 234.839, 36.4818);
    path_3.cubicTo(214.053, 20.0086, 181.566, 3.50006, 134.768, 3.5);
    path_3.cubicTo(87.9684, 3.49994, 55.0931, 20.0097, 33.9188, 36.4899);
    path_3.cubicTo(23.3251, 44.7351, 15.6552, 52.9775, 10.6392, 59.1501);
    path_3.cubicTo(8.13152, 62.236, 6.28848, 64.8028, 5.07618, 66.5916);
    path_3.cubicTo(4.47008, 67.486, 4.02178, 68.1856, 3.72705, 68.6581);
    path_3.cubicTo(3.63709, 68.8023, 3.56145, 68.9254, 3.5, 69.0263);
    path_3.close();
    path_3.moveTo(266, 68.6124);
    path_3.lineTo(267.312, 67.886);
    path_3.lineTo(267.5, 68.225);
    path_3.lineTo(267.5, 119.225);
    path_3.lineTo(169.199, 145.5);
    path_3.lineTo(99.4601, 145.5);
    path_3.lineTo(0.5, 119.227);
    path_3.lineTo(0.5, 68.2109);
    path_3.lineTo(0.7005, 67.8632);
    path_3.lineTo(2, 68.6124);
    path_3.cubicTo(0.7005, 67.8632, 0.701036, 67.8622, 0.701719, 67.8611);
    path_3.lineTo(0.703822, 67.8574);
    path_3.lineTo(0.71068, 67.8456);
    path_3.lineTo(0.735031, 67.804);
    path_3.cubicTo(0.756001, 67.7683, 0.786453, 67.7169, 0.826455, 67.6501);
    path_3.cubicTo(0.906457, 67.5166, 1.02467, 67.3221, 1.18162, 67.0704);
    path_3.cubicTo(1.49552, 66.5672, 1.96446, 65.8357, 2.59277, 64.9086);
    path_3.cubicTo(3.8493, 63.0545, 5.74379, 60.4173, 8.31097, 57.2582);
    path_3.cubicTo(13.4445, 50.941, 21.2734, 42.5303, 32.0762, 34.1224);
    path_3.cubicTo(53.6949, 17.2964, 87.2036, 0.499939, 134.768, 0.5);
    path_3.cubicTo(182.334, 0.500061, 215.463, 17.2977, 236.702, 34.1307);
    path_3.cubicTo(247.315, 42.5414, 254.952, 50.955, 259.942, 57.2747);
    path_3.cubicTo(262.438, 60.435, 264.272, 63.0734, 265.487, 64.9285);
    path_3.cubicTo(266.094, 65.8562, 266.546, 66.5882, 266.849, 67.0919);
    path_3.cubicTo(267, 67.3438, 267.114, 67.5386, 267.191, 67.6723);
    path_3.cubicTo(267.229, 67.7391, 267.259, 67.7907, 267.279, 67.8265);
    path_3.lineTo(267.303, 67.8683);
    path_3.lineTo(267.309, 67.8802);
    path_3.lineTo(267.311, 67.8838);
    path_3.cubicTo(267.312, 67.885, 267.312, 67.886, 266, 68.6124);
    path_3.close();

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = const Color(0xffC06510).withOpacity(1.0);
    canvas.drawPath(path_3, paint3Fill);

    Path path_4 = Path();
    path_4.moveTo(74, 44);
    path_4.lineTo(195, 44);
    path_4.lineTo(195, 116);
    path_4.lineTo(74, 116);
    path_4.lineTo(74, 44);
    path_4.close();

    Paint paint4Fill = Paint()..style = PaintingStyle.fill;
    paint4Fill.color = const Color(0xffF0C4C4).withOpacity(1.0);
    canvas.drawPath(path_4, paint4Fill);

    Path path_5 = Path();
    path_5.moveTo(192, 47);
    path_5.lineTo(77, 47);
    path_5.lineTo(77, 113);
    path_5.lineTo(192, 113);
    path_5.lineTo(192, 47);
    path_5.close();
    path_5.moveTo(74, 44);
    path_5.lineTo(74, 116);
    path_5.lineTo(195, 116);
    path_5.lineTo(195, 44);
    path_5.lineTo(74, 44);
    path_5.close();

    Paint paint5Fill = Paint()..style = PaintingStyle.fill;
    paint5Fill.color = const Color(0xffC76237).withOpacity(1.0);
    canvas.drawPath(path_5, paint5Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

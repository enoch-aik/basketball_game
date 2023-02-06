import 'package:basketball_game/backboard.dart';
import 'package:flame/components.dart';

import '../game/basketball_game.dart';

class BackboardComponent extends CustomPainterComponent
    with HasGameRef<BasketBallGame> {
  @override
  void onLoad() {
    super.onLoad();
    painter = BackboardCP();
    position = Vector2(1.7, 6.5);
    width = gameRef.size.x-3;
    height = 20;
    //anchor = Anchor.center;
  }
}

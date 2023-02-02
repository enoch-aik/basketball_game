import 'package:basketball_game/constants/image_assets.dart';
import 'package:basketball_game/game/basketball_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class BallComponent extends SpriteComponent
    with HasGameRef<BasketBallGame>, Draggable {
  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(ImageAssets.basketballSprite);
    _rightBound = gameRef.size.x - 70;
    _leftBound = gameRef.size.x + 70;
    _upBound = gameRef.size.y + 70;
    _downBound = gameRef.size.y - 70;

    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 70);
    height = 100;
    width = 100;
    anchor = Anchor.center;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    if (parent is! BasketBallGame) {
      return true;
    }

    position.add(info.delta.game);
    return false;
  }
}

import 'package:basketball_game/constants/image_assets.dart';
import 'package:basketball_game/game/basketball_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/gestures.dart';

class BallComponent extends SpriteComponent
    with HasGameRef<BasketBallGame>, Draggable {
  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;
  late bool _swiped = false;
  late double _x = 20;

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
  void update(dt) {
    super.update(dt);
    if (_swiped) {
      // position.moveToTarget(Vector2(_x,100), 15);
    }
    //position.moveToTarget(Vector2(100,100), 10);
  }

  /*@override
  bool onDragStart(DragStartInfo info) {
    _x = info.eventPosition.game.x;
    print(_x);
    print(gameRef.size.x);
    print(gameRef.size.y);
    return true;
  }*/
  @override
  bool onDragUpdate(DragUpdateInfo info) {
    double initialPosition = position.x;
    if (parent is BasketBallGame) {
      if ((position.y > gameRef.size.y - 200) && !_swiped) {
       position.add(info.delta.game);
       _x = position.x;

        _swiped = true;
        /*print(position.x);
        print(info.delta.viewport);
        print(info.delta.global);
        print(info.delta.game);
        */
        //_x = info.delta.global.x+position.x;
        //position.add(info.delta.game);

        //position.moveToTarget(Vector2(info.delta.game.x,100), 30);
        /*position.add(Vector2(
            info.delta.game.x, info.delta.game.y));*/

        return true;
      }
      return true;
    }
    //position.add(info.delta.game);

    return true;
  }

  void swipe(DragEndDetails details) {
    // Apply a force to the ball in the direction of the swipe
    x += details.velocity.pixelsPerSecond.dx * 0.1;
    y += details.velocity.pixelsPerSecond.dy * 0.1;
  }
}

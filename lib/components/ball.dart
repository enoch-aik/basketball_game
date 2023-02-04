import 'package:basketball_game/constants/image_assets.dart';
import 'package:basketball_game/game/basketball_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/gestures.dart';
import 'package:forge2d/src/dynamics/body.dart';

class BallComponent extends BodyComponent with Draggable {
  final Vector2 position;

  BallComponent(this.position);

  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;
  late bool _swiped = false;
  late double _x = 20;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(SpriteComponent()
      ..sprite = await gameRef.loadSprite(ImageAssets.basketballSprite)
      ..anchor = Anchor.center
      ..size = Vector2.all(13));
    // renderBody = false;
    _rightBound = gameRef.size.x - 70;
    _leftBound = gameRef.size.x + 70;
    _upBound = gameRef.size.y + 70;
    _downBound = gameRef.size.y - 70;

    /*position = Vector2(gameRef.size.x / 2, gameRef.size.y - 70);
    height = 100;
    width = 100;
    anchor = Anchor.center;*/
  }

  @override
  Body createBody() {
    Shape shape = CircleShape()..radius = 6;
    BodyDef bodyDef = BodyDef(
        angularDamping: .8,
        position: Vector2(gameRef.size.x / 2, gameRef.size.y),
        type: BodyType.dynamic);
    FixtureDef fixtureDef = FixtureDef(
      shape,
      friction: .4,
      density: 1,
      restitution: .4,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onDragStart(DragStartInfo info) {
    return true;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    body.applyLinearImpulse(Vector2(info.delta.game.x,info.delta.game.y) * 500);
    // print(info.delta.game.toString());
    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    // print(body.position.y);
    if (body.position.y <= 50) {
      //world.stepDt(-dt);
      //body.position.moveToTarget(Vector2(0, 0), 30);
      //body.applyLinearImpulse(Vector2(0, gameRef.size.y - 10));
    }
  }

  @override
  bool onDragEnd(DragEndInfo info) {
    return true;
  }
}

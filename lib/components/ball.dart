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

  bool _enableSwipe = true;
  late Vector2 _drag;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(SpriteComponent()
      ..sprite = await gameRef.loadSprite(ImageAssets.basketballSprite)
      ..anchor = Anchor.center
      ..size = Vector2.all(11));
    renderBody = true;

    /*position = Vector2(gameRef.size.x / 2, gameRef.size.y - 70);
    height = 100;
    width = 100;
    anchor = Anchor.center;*/
  }

  @override
  Body createBody() {
    Shape shape = CircleShape()..radius = 5;
    BodyDef bodyDef = BodyDef(
        linearDamping: 0.5,
        userData: this,
        angularDamping: .8,
        position: Vector2(gameRef.size.x / 2, gameRef.size.y),
        type: BodyType.dynamic);
    FixtureDef fixtureDef = FixtureDef(
      shape,
      friction: 0.4,
      density: 1.0,
      restitution: 0.4,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

/*
  @override
  bool onDragStart(DragStartInfo info) {
    body.applyLinearImpulse(info.eventPosition.game*1000);
    return true;
  }
*/

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    if (_enableSwipe) {
      body.applyLinearImpulse(
        Vector2(info.delta.game.x, -4) * 2000,
      );
      _drag = info.delta.game;
    }

    // print(info.delta.game.toString());
    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    //print(body.position.y);
    if (body.position.y <= 55) {
      _enableSwipe = false;
      //print('reached limit');
      if (body.position.y <= 20) {
        body.applyForce(
            Vector2(0, 3000 * body.position.distanceTo(Vector2(0, 0))),
            point: body.position);
      }
    } else {
      // _enableSwipe = true;
    }
  }

  @override
  bool onDragEnd(DragEndInfo info) {
    return true;
  }
}

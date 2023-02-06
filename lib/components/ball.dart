import 'dart:math';

import 'package:basketball_game/constants/image_assets.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BallComponent extends BodyComponent with Draggable, CollisionCallbacks {
  final Vector2 position;
  late SpriteComponent _ball;

  BallComponent(this.position);

  bool _canSwipe = true;
  bool _hasPeaked = false;
  bool _createNewBall = false;
  final Random _ballPosition = Random();

  @override
  Future<void> onLoad() async {
    _ball = SpriteComponent()
      ..sprite = await gameRef.loadSprite(ImageAssets.basketballSprite)
      ..anchor = Anchor.center
      ..opacity = 1
      ..size = Vector2.all(11);

    await super.onLoad();
    add(_ball);
    renderBody = false;
  }

  @override
  Body createBody() {
    Shape shape = CircleShape()..radius = 5.5;
    Filter filter = Filter();
    filter.categoryBits = 0x0002;
    filter.maskBits = 0x0001;
    Vector2 ballPos = Vector2(
        _ballPosition.nextInt(gameRef.size.x ~/ 1.15).toDouble() + 0.2,
        position.y);
    print(ballPos);
    opacity = 0.1;
    BodyDef bodyDef = BodyDef(
      linearDamping: 0.5,
      userData: this,
      angularDamping: .8,
      position: ballPos,
      type: BodyType.dynamic,
    );
    FixtureDef fixtureDef = FixtureDef(shape,
        friction: 0.4, density: 10.0, restitution: 0, filter: filter);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    if (_canSwipe) {
      body.applyLinearImpulse(
        Vector2(info.delta.game.x, -4) * 2000,
      );
      _createNewBall = true;
    }

    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    double height = body.position.y;
    double maxHeight = 0; // Maximum height of the screen
    double minHeight = gameRef.size.y;
    double ratio = (maxHeight - minHeight) / (height - minHeight);
    double size = min(max(ratio, 0.0), 1.0);
    _ball.width = size * 11;

    _ball.height = size * 11;
    body.sleepTime = 2;
    if (body.position.y <= 55) {
      _canSwipe = false;
      //print('reached limit');
      if (body.position.y <= 20) {
        body.applyForce(
            Vector2(0, 3000 * body.position.distanceTo(Vector2(0, 0))),
            point: body.position);
        _hasPeaked = true;
        _createNewBall ? gameRef.add(BallComponent(position)) : null;
        _createNewBall = false;
      }
    }
    if (_hasPeaked && !_canSwipe && body.position.y >= gameRef.size.y - 30) {
      if (_ball.opacity > 0.02) {
        _ball.opacity -= dt / 2.3;
      }
      /*body.position.y >= gameRef.size.y - 7
          ? body.setAwake(false)
          : null;*/
      if (!body.isAwake || !body.isActive) {
        world.destroyBody(body);
        gameRef.remove(this);
      }

      //game.add(BallComponent(position));
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is BallComponent) {}
  }
}

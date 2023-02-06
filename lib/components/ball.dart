import 'dart:math';

import 'package:basketball_game/components/boundary.dart';
import 'package:basketball_game/constants/audio.dart';
import 'package:basketball_game/constants/image_assets.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_audio/audio_pool.dart';

class BallComponent extends BodyComponent with Draggable, ContactCallbacks {
  final Vector2 position;
  late SpriteComponent _ball;
  late AudioPool bounce;
  late AudioPool hitRim;
  late AudioPool hitWall;
  late AudioPool swish;

  BallComponent(this.position);

  bool _canSwipe = true;
  bool _hasPeaked = false;
  bool _createNewBall = false;
  bool _canDrag = true;
  final Random _ballPosition = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _ball = SpriteComponent()
      ..sprite = await gameRef.loadSprite(ImageAssets.basketballSprite)
      ..anchor = Anchor.center
      ..opacity = 1
      ..size = Vector2.all(11);
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
    // print(ballPos);
    BodyDef bodyDef = BodyDef(
      linearDamping: 0.5,
      userData: this,
      angularDamping: .8,
      position: ballPos,
      type: BodyType.dynamic,
    );
    FixtureDef fixtureDef = FixtureDef(shape,
        friction: 0.4, density: 4.0, restitution: 0.1, filter: filter);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onDragStart(DragStartInfo info) {
    if (_canDrag) {
      FlameAudio.play(AudioAssets.shoot2, volume: 0.5);
      _canDrag = false;
    }
    return super.onDragStart(info);
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    if (_canSwipe) {
      body.applyLinearImpulse(
        Vector2(info.delta.game.x, -3.2) * 2000,
      );
      _createNewBall = true;
    }

    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    double height = body.position.y;
    double maxHeight = 0;
    double minHeight = gameRef.size.y;
    double ratio = (maxHeight - height) / (maxHeight - minHeight);
    double size = min(max(ratio, 0.0), 1.0);
    _ball.width = 8.21 + (size * 3);
    _ball.height = 8.21 + (size * 3);
    body.sleepTime = 1;
    if (body.position.y <= 55) {
      _canSwipe = false;
      if (body.position.y <= 20) {
        body.applyForce(
            Vector2(0, 8000 * body.position.distanceTo(Vector2(0, 0))),
            point: body.position);
      } else if (body.linearVelocity.y < Vector2.all(1).y && !_hasPeaked) {
        _hasPeaked = true;
        _createNewBall ? gameRef.add(BallComponent(position)) : null;
        _createNewBall = false;
      }
    }
    if (_hasPeaked && !_canSwipe && body.position.y >= gameRef.size.y - 20) {
      if (_ball.opacity > 0.04) {
        _ball.opacity -= 0.04;
      }
      _ball.opacity == 0.02 ? body.setAwake(false) : null;
      if (!body.isAwake || !body.isActive) {
        world.destroyBody(body);
        gameRef.remove(this);
      }

      //game.add(BallComponent(position));
    }
    if (body.position.x > gameRef.size.x || body.position.x < 0) {
      world.destroyBody(body);
      gameRef.remove(this);
    }
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    if (other is WallComponent) {
      FlameAudio.play(AudioAssets.hitWall2, volume: 0.2);
    }
  }
}

import 'dart:math';

import 'package:basketball_game/components/boundary.dart';
import 'package:basketball_game/components/rim.dart';
import 'package:basketball_game/constants/audio.dart';
import 'package:basketball_game/constants/image_assets.dart';
import 'package:basketball_game/game/basketball_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BallComponent extends BodyComponent<BasketBallGame>
    with Draggable, CollisionCallbacks, ContactCallbacks {
  BallComponent() : super(priority: 7);
  late SpriteComponent _ball;
  late Filter filter = Filter()
    ..categoryBits = 2
    ..maskBits = 1;
  late FixtureDef fixtureDef;

  bool _canSwipe = true;
  bool _hasPeaked = false;
  bool _hasReachedTop = false;
  bool _createNewBall = false;
  bool _canDrag = true;
  bool _hasHitRim = false;
  bool _hasScored = false;
  bool _hasRecordedScore = false;

  //double _ballRadius = 4.5;
  final Random _ballPosition = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _ball = SpriteComponent()
      ..sprite = await gameRef.loadSprite(ImageAssets.basketballSprite)
      ..anchor = Anchor.center
      ..opacity = 1
      ..size = Vector2.all(8.8);
    add(_ball);
    renderBody = false;
    body.sleepTime = 5;
  }

  @override
  Body createBody() {
    Shape shape = CircleShape();
    shape.radius = 4.0;
    Vector2 ballPos = Vector2(
        _ballPosition.nextInt(gameRef.size.x ~/ 1.15).toDouble() + 1,
        gameRef.size.y);
    print(ballPos);
    BodyDef bodyDef = BodyDef(
      linearDamping: 0.6,
      userData: this,
      angularDamping: 0,
      //linearVelocity: Vector2(0, 50),
      angularVelocity: 0,
      position: ballPos,
      type: BodyType.dynamic,
    );
    fixtureDef = FixtureDef(shape,
        friction: 0, density: 3.0, restitution: 0.2, filter: filter);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onDragStart(DragStartInfo info) {
    if (_canDrag) {
      FlameAudio.play(AudioAssets.shoot2, volume: 0.2);
      _canDrag = false;
    }
    return super.onDragStart(info);
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    if (_canSwipe) {
      body.linearVelocity = info.delta.game * 100;
      body.applyLinearImpulse(
        Vector2(info.delta.game.x, -5) * 8000,
      );
      _createNewBall = true;
    }

    return true;
  }

  int i = 1;

  @override
  void update(double dt) async {
    super.update(dt);
    if (_hasPeaked &&
        isBallBetweenRim(body.position) &&
        !_hasRecordedScore &&
        _hasReachedTop) {
      gameRef.score.value += 1;
      _hasRecordedScore = true;
    }
    /*if (_hasPeaked &&
        ballTouchesRim(
          ballPosition: body.position,
        )) {
      print('entered');
    }*/
    if (body.position.y <= 55) {
      _canSwipe = false;
      if (body.position.y <= 15) {
        body.createFixture(FixtureDef(CircleShape()..radius = 4.0,
            filter: Filter()
              ..maskBits = 2
              ..categoryBits = 4));
        priority = 5;

        body.applyForce(
            Vector2(0, 15000 * body.position.distanceTo(Vector2(0, 0))),
            point: body.position);
        _hasReachedTop = true;
        _hasPeaked = true;
      } else if (body.linearVelocity.y < Vector2.all(0.1).y && !_hasPeaked) {
        _hasPeaked = true;
        _createNewBall ? gameRef.add(BallComponent()) : null;
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
    } else {}
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    if (other is WallComponent) {
      //  FlameAudio.play(AudioAssets.hitWall2, volume: 0.2);
    }
    if (other is RimLineComponent) {
      gameRef.score.value += 1;
      _hasScored = true;
    }
    if (other is RimComponent && _hasPeaked && !_hasHitRim) {
      FlameAudio.play(AudioAssets.hitWall, volume: 0.1);
      _hasHitRim = true;
    }
  }

  bool isBallBetweenRim(Vector2 ball) {
    Vector2 startRim = Vector2((gameRef.size.x / 2) - 6.7, 30);
    Vector2 endRim = Vector2((gameRef.size.x / 2) + 6.7, 30);
    double ballToStartRim = (ball - startRim).length;
    double ballToEndRim = (ball - endRim).length;
    double startRimToEndRim = (startRim - endRim).length;
// change this value to adjust tolerance
    double tolerance = 0.1;

    return (ballToStartRim + ballToEndRim - startRimToEndRim).abs() < tolerance;
  }
}

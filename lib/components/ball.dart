import 'dart:math';

import 'package:basketball_game/components/rim.dart';
import 'package:basketball_game/constants/audio.dart';
import 'package:basketball_game/constants/image_assets.dart';
import 'package:basketball_game/game/basketball_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BallComponent extends BodyComponent<BasketBallGame>
    with Draggable, CollisionCallbacks, ContactCallbacks {
  BallComponent() : super(priority: 7);

  //initialize ball sprite in onLoad()
  late SpriteComponent _ball;
  late FixtureDef fixtureDef;

  //this checks if this ball component can be swiped
  bool _canSwipe = true;
  bool _hasPeaked = false;

  // this checks if the ball has reached the peak of the screen

  bool _hasReachedTop = false;

//this checks if a new ball has been created
  bool _createNewBall = false;

  bool _canDrag = true;

  //checks if the ball already hit the rim, so a sound can be played
  bool _hasHitRim = false;

  //checks if a score has been recorded ==> this is to avoid duplicate score based on game's logic
  bool _hasRecordedScore = false;

//for creating random ball position
  final Random _ballPosition = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    //load ball component here
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
    //add categoryBit and maskBits to body to detect collision
    Filter filter = Filter()
      ..categoryBits = 2
      ..maskBits = 1;

    // define shape and size
    Shape shape = CircleShape();
    shape.radius = 4.0;
    // define ball position
    Vector2 ballPos = Vector2(
        _ballPosition.nextInt(gameRef.size.x ~/ 1.15).toDouble() + 1,
        gameRef.size.y - 1);
    //define bodyDef
    BodyDef bodyDef = BodyDef(
      linearDamping: 0.6,
      userData: this,
      /*
      angularDamping: 0,
      angularVelocity: 0,*/
      position: ballPos,
      type: BodyType.dynamic,
    );
    //define fixtureDef
    fixtureDef = FixtureDef(shape,
        friction: 0, density: 3.0, restitution: 0.2, filter: filter);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onDragStart(DragStartInfo info) {
    //play sound when the ball is swipted
    if (_canDrag) {
      FlameAudio.play(AudioAssets.shoot, volume: 0.8);
      _canDrag = false;
    }
    return super.onDragStart(info);
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    //move the ball towards direction of the user's swipe
    if (_canSwipe) {
      body.linearVelocity = info.delta.game * 100;
      body.applyLinearImpulse(
        Vector2(info.delta.game.x, -5) * 8000,
      );
      _createNewBall = true;
    }
    return true;
  }

  @override
  void update(double dt) async {
    super.update(dt);

    //checks if the ball has peaked and entered the rim to add score
    if (_hasPeaked &&
        isBallBetweenRim(body.position) &&
        !_hasRecordedScore &&
        _hasReachedTop) {
      gameRef.score.value += 1;
      _hasRecordedScore = true;
    }
    //check to disable swipe of a ball after it leaves the bottom of the screen
    if (body.position.y <= 55) {
      _canSwipe = false;
      if (body.position.y <= 15) {
        body.createFixture(FixtureDef(CircleShape()..radius = 4.0,
            filter: Filter()
              ..maskBits = 2
              ..categoryBits = 4));
        priority = 5;
        //send the ball back down
        body.applyForce(
            Vector2(0, 10000 * body.position.distanceTo(Vector2(0, 0))),
            point: body.position);
        _hasReachedTop = true;
        _hasPeaked = true;
      }
      //if the ball no longer has velocity to move upwards, create new ball
      else if (body.linearVelocity.y < Vector2.all(0.1).y && !_hasPeaked) {
        _hasPeaked = true;
        _createNewBall ? gameRef.add(BallComponent()) : null;
        _createNewBall = false;
      }
    }
    //reduce opacity of ball with dt
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
    //remove ball if is outside the game screen
    if (body.position.x > gameRef.size.x || body.position.x < 0) {
      world.destroyBody(body);
      gameRef.remove(this);
    } else {}
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
/*
    if (other is WallComponent) {
    // I already removed this AudioAsset
       FlameAudio.play(AudioAssets.hitWall2, volume: 0.2);
    }*/
    //play audio if ball hits rim
    if (other is RimComponent && _hasPeaked && !_hasHitRim) {
      FlameAudio.play(AudioAssets.hitWall, volume: 0.7);
      _hasHitRim = true;
    }
  }

//to check if the ball entered the rim
  bool isBallBetweenRim(Vector2 ball) {
    Vector2 startRim = Vector2((gameRef.size.x / 2) - 6.7, 30);
    Vector2 endRim = Vector2((gameRef.size.x / 2) + 6.7, 30);
    double ballToStartRim = (ball - startRim).length;
    double ballToEndRim = (ball - endRim).length;
    double startRimToEndRim = (startRim - endRim).length;
    // change this value to adjust tolerance btw the ball and rim
    double tolerance = 0.1;
    return (ballToStartRim + ballToEndRim - startRimToEndRim).abs() < tolerance;
  }
}

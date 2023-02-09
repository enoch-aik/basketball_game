import 'dart:math';

import 'package:basketball_game/components/ball.dart';
import 'package:basketball_game/components/boundary.dart';
import 'package:basketball_game/constants/audio.dart';
import 'package:basketball_game/constants/image_assets.dart';
import 'package:basketball_game/game/basketball_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_audio/audio_pool.dart';

class RimComponent extends BodyComponent with ContactCallbacks {
  final Vector2 position;
  final bool collidesWithBall;

  RimComponent(this.position, this.collidesWithBall) : super(priority: 3);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    //add(_ball);
    renderBody = true;
  }

  @override
  Body createBody() {
    Filter filter = Filter()
      ..categoryBits = collidesWithBall ? 0x0001 : 0x0002
      ..maskBits = collidesWithBall ? 0x0002 : 0x0004;
    Shape shape = CircleShape()..radius = 0.4;
    // print(ballPos);
    BodyDef bodyDef = BodyDef(
      //linearDamping: 0.5,
      userData: this,
      gravityScale: Vector2(0, 20),
      //angularDamping: .8,
      position: position,
      type: BodyType.static,
    );
    FixtureDef fixtureDef = FixtureDef(shape,
        friction: .0, restitution: .15, density: 0, filter: filter);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

/*@override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    if (other is BodyComponent) {
      FlameAudio.play(AudioAssets.hitWall2, volume: 0.2);
    }
  }*/
}

class BackRimComponent extends SpriteComponent with HasGameRef<BasketBallGame> {
  BackRimComponent() : super(priority: 4);

  @override
  void onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(ImageAssets.backRim);
    position = Vector2(gameRef.size.x / 2 - 7, 26.1);
    width = gameRef.size.x * 0.37;
    height = 2;
    //height = game.size.y * 0.9;
    //anchor = Anchor.center;
  }
}

class FrontRimComponent extends SpriteComponent
    with HasGameRef<BasketBallGame> {
  FrontRimComponent() : super(priority: 6);

  @override
  void onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(ImageAssets.frontRim);
    position = Vector2(gameRef.size.x / 2 - 7, 28);
    width = gameRef.size.x * 0.37;
    height = 2;
    //height = game.size.y * 0.9;
    //anchor = Anchor.center;
  }
}
/*
class RimLineComponent extends SpriteComponent
    with HasGameRef<BasketBallGame> {
  RimLineComponent() : super(priority: 6);

  @override
  void onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(ImageAssets.frontRim);
    position = Vector2(gameRef.size.x / 2 - 7, 30);
    width = gameRef.size.x * 0.37;
    height = 2;
    //height = game.size.y * 0.9;
    //anchor = Anchor.center;
  }
}*/
class RimLineComponent extends BodyComponent with ContactCallbacks {
  RimLineComponent() : super(priority: 2);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    //add(_ball);
    renderBody = false;
  }

  @override
  Body createBody() {
    Vector2 gameSize = gameRef.size;

    Filter filter = Filter()
      ..categoryBits = 5
      ..maskBits = 5;
    Shape shape = EdgeShape()
      ..set(Vector2((gameSize.x / 2) - 6.7, 30),
          Vector2((gameSize.x / 2) + 6, 30));
    // print(ballPos);
    BodyDef bodyDef = BodyDef(
      userData: this,
      position: Vector2.zero(),
      type: BodyType.static,
    );
    FixtureDef fixtureDef = FixtureDef(shape, filter: filter);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

}

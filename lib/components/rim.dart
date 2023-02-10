

import 'package:basketball_game/constants/image_assets.dart';
import 'package:basketball_game/game/basketball_game.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class RimComponent extends BodyComponent with ContactCallbacks {
  final Vector2 position;
  final bool collidesWithBall;

  RimComponent(this.position, this.collidesWithBall) : super(priority: 3);

  @override
  Body createBody() {
    renderBody = false;
    Filter filter = Filter()
      ..categoryBits = collidesWithBall ? 0x0001 : 0x0002
      ..maskBits = collidesWithBall ? 0x0002 : 0x0004;
    Shape shape = CircleShape()..radius = 0.4;
    // print(ballPos);
    BodyDef bodyDef = BodyDef(

      userData: this,
      gravityScale: Vector2(0, 20),
      position: position,
      type: BodyType.static,
    );
    FixtureDef fixtureDef = FixtureDef(shape,
        friction: .0, restitution: .15, density: 0, filter: filter);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
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
  }
}
class RimLineComponent extends BodyComponent with ContactCallbacks {
  RimLineComponent() : super(priority: 2);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

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
    BodyDef bodyDef = BodyDef(
      userData: this,
      position: Vector2.zero(),
      type: BodyType.static,
    );
    FixtureDef fixtureDef = FixtureDef(shape, filter: filter);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

}

import 'package:basketball_game/components/ball.dart';
import 'package:basketball_game/constants/audio.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

List<Component> createBoundaries(Forge2DGame game) {
  final topLeft = Vector2.zero();
  final bottomRight = game.screenToWorld(game.camera.viewport.effectiveSize);
  final topRight = Vector2(bottomRight.x, topLeft.y);
  final bottomLeft = Vector2(topLeft.x, bottomRight.y);

  return [
    WallComponent(topLeft, topRight),
    WallComponent(topRight, bottomRight),
    FloorComponent(bottomRight, bottomLeft, isBottom: true),
    WallComponent(bottomLeft, topLeft),
  ];
}

class WallComponent extends BodyComponent with ContactCallbacks {
  final Vector2 start;
  final Vector2 end;
  final bool isBottom;

  WallComponent(this.start, this.end, {this.isBottom = true});

  @override
  Body createBody() {
    /*Filter filter = Filter();
    filter.categoryBits = isBottom ? 0x0001 : 0x0002;
    filter.maskBits = isBottom ? 0x0002 : 0x0001;*/
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(
      shape,
      friction: 0.3,
      restitution: .3,
      //filter: filter
    );
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: Vector2.zero(),
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class FloorComponent extends BodyComponent with ContactCallbacks {
  final Vector2 start;
  final Vector2 end;
  final bool isBottom;

  FloorComponent(this.start, this.end, {this.isBottom = true});

  @override
  Body createBody() {
    /* Filter filter = Filter();
    filter.categoryBits = isBottom ? 0x0001 : 0x0002;
    filter.maskBits = isBottom ? 0x0002 : 0x0001;*/
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(
      shape,
      friction: 0.3,
      restitution: .3,
      //filter: filter
    );
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: Vector2.zero(),
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

}

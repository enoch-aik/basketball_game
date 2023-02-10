import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

List<Component> createBoundaries(Forge2DGame game) {
  Vector2 gameSize = game.screenToWorld(game.camera.viewport.effectiveSize);
  final topLeft = Vector2.zero();
  final bottomRight = Vector2(gameSize.x, gameSize.y-1);
  final topRight = Vector2(bottomRight.x, topLeft.y);
  final bottomLeft = Vector2(topLeft.x, bottomRight.y);

  return [
    WallComponent(topLeft, topRight),
    WallComponent(Vector2(bottomRight.x, bottomRight.y - 8), bottomRight),
    FloorComponent(bottomRight, bottomLeft),
    WallComponent(bottomLeft, Vector2(bottomLeft.x, bottomLeft.y - 8)),
  ];
}

class WallComponent extends BodyComponent with ContactCallbacks {
  final Vector2 start;
  final Vector2 end;

  WallComponent(
    this.start,
    this.end,
  );

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(
      shape,
      friction: 0.3,
      restitution: .3,
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

  FloorComponent(
    this.start,
    this.end,
  );

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(
      shape,
      friction: 1,
      restitution: .3,
    );
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2.zero(),
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

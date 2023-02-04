
import 'package:flame_forge2d/flame_forge2d.dart';

List<Wall> createBoundaries(Forge2DGame game) {
  final topLeft = Vector2.zero();
  final bottomRight = game.screenToWorld(game.camera.viewport.effectiveSize);
  final topRight = Vector2(bottomRight.x, topLeft.y);
  final bottomLeft = Vector2(topLeft.x, bottomRight.y);

  return [
    Wall(topLeft, topRight),
    Wall(topRight, bottomRight),
    Wall(bottomRight, bottomLeft),
    Wall(bottomLeft, topLeft),
  ];
}

class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;

  Wall(this.start, this.end);

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(shape, friction: 1);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: Vector2.zero(),
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class BottomBoundary extends BodyComponent {
  @override
  Future<void> onLoad ()async {
    await super.onLoad();
    renderBody = false;

  }
  @override
  Body createBody() {
    Shape shape = EdgeShape()
      ..set(
          Vector2(0, gameRef.size.y), Vector2(gameRef.size.x, gameRef.size.y));
    BodyDef bodyDef = BodyDef(position: Vector2.zero(), type: BodyType.static);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3, density: 1);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class TopBoundary extends BodyComponent {
  @override
  Future<void> onLoad ()async {
    await super.onLoad();
    renderBody = false;

  }
  @override
  Body createBody() {
    Shape shape = EdgeShape()..set(Vector2(0, 0), Vector2(gameRef.size.x, 0));
    BodyDef bodyDef = BodyDef(position: Vector2.zero(), type: BodyType.static);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3, density: 1);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class LeftBoundary extends BodyComponent {
  @override
  Future<void> onLoad ()async {
    await super.onLoad();
    renderBody = false;

  }
  @override
  Body createBody() {
    Shape shape = EdgeShape()..set(Vector2(0, 0), Vector2(0, gameRef.size.y));
    BodyDef bodyDef = BodyDef(position: Vector2.zero(), type: BodyType.static);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3, density: 1);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class RightBoundary extends BodyComponent {
  @override
  Future<void> onLoad ()async {
    await super.onLoad();
    renderBody = false;

  }
  @override
  Body createBody() {
    Shape shape = EdgeShape()
      ..set(
          Vector2(gameRef.size.x, 0), Vector2(gameRef.size.x, gameRef.size.y));
    BodyDef bodyDef = BodyDef(position: Vector2.zero(), type: BodyType.static);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3, density: 1);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

import 'dart:math';

import 'package:basketball_game/components/boundary.dart';
import 'package:basketball_game/constants/audio.dart';
import 'package:basketball_game/constants/image_assets.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_audio/audio_pool.dart';

class RimComponent extends BodyComponent with Draggable, ContactCallbacks {
  final Vector2 position;
  final bool collidesWithBall;

  RimComponent(this.position, this.collidesWithBall);

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
    Shape shape = CircleShape()..radius = 0.5;
    // print(ballPos);
    BodyDef bodyDef = BodyDef(
      linearDamping: 0.5,
      userData: this,
      angularDamping: .8,
      position: position,
      type: BodyType.static,
    );
    FixtureDef fixtureDef = FixtureDef(shape,
        friction: 0.5, density: 4.0, restitution: 0.0, filter: filter);
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

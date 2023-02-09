import 'package:basketball_game/backboard.dart';
import 'package:basketball_game/components/backboard.dart';
import 'package:basketball_game/components/ball.dart';
import 'package:basketball_game/components/boundary.dart';
import 'package:basketball_game/components/mural_component.dart';
import 'package:basketball_game/components/rim.dart';
import 'package:basketball_game/constants/audio.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BasketBallGame extends Forge2DGame
    with HasDraggables, HasCollisionDetection {
  BasketBallGame() {
    //World world = World(Vector2(0,0));
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final boundaries = createBoundaries(this);
    boundaries.forEach(add);
    Vector2 gameSize = screenToWorld(camera.viewport.effectiveSize);
    // Preload audio files
    print(gameSize);
    await FlameAudio.audioCache.loadAll([
      AudioAssets.bounce1,
      AudioAssets.bounce2,
      AudioAssets.hitRim,
      AudioAssets.hitWall,
      AudioAssets.hitWall2,
      AudioAssets.swish1,
      AudioAssets.swish2,
      AudioAssets.buzzer,
      AudioAssets.shoot,
      AudioAssets.shoot2,
      AudioAssets.bgAudio
    ]);
    FlameAudio.loopLongAudio(AudioAssets.bgAudio,volume: 0.1);
    addAll([
      MuralComponent(),
      BackboardComponent(),
      RimComponent(Vector2((gameSize.x/2)+6, 28), false),
      RimComponent(Vector2((gameSize.x/2)-6.7, 28), false),
      BackRimComponent(),
      FrontRimComponent(),
      BallComponent()
    ]);
  }
}

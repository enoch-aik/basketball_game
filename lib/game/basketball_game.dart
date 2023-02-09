
import 'package:basketball_game/components/backboard.dart';
import 'package:basketball_game/components/ball.dart';
import 'package:basketball_game/components/boundary.dart';
import 'package:basketball_game/components/mural_component.dart';
import 'package:basketball_game/components/rim.dart';
import 'package:basketball_game/constants/audio.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart' hide Timer;
import 'package:flutter/foundation.dart';

enum GameOverlays { gameOver, main, scoreboard }

class BasketBallGame extends Forge2DGame
    with HasDraggables, HasCollisionDetection {
  BasketBallGame() {
    //World world = World(Vector2(0,0));
  }

  late Timer _timer;

  //int _remainingTime = 30;
  ValueNotifier<int> timer = ValueNotifier(30);
  ValueNotifier<int> score = ValueNotifier(0);
  bool startedGame = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    /*TextComponent timerText = TextBoxComponent(
        text: '$timer',
        position: Vector2(10, 10),
        anchor: Anchor.topLeft,
        textRenderer: TextPaint(
            style: TextStyle(
                fontFamily: 'Enhanced LED Board-7',
                fontSize: 30,
                color: BasicPalette.black.color)));
    add(timerText);*/
    await loadAllComponents();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update timer.
    _timer.update(dt);

    /* if (timer.value == 0) {
      pauseEngine();
    }*/

    // timer.value +=1;
  }

  void resetTimer() {
    timer.value = 30;
  }

  void resetScore() {
    score.value = 0;
  }

  void addMenu(GameOverlays overlay) {}

  loadAllComponents() async {
    _timer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (timer.value == 0) {
          // Pause the game.
          pauseEngine();
          removeWhere((component) => component == BallComponent());
          overlays.remove(GameOverlays.scoreboard.name);
          overlays.add(GameOverlays.gameOver.name);
          // Display game over menu.
        } else {
          // Decrement time by one second.
          timer.value -= 1;
        }
      },
    );
    final boundaries = createBoundaries(this);
    boundaries.forEach(add);
    Vector2 gameSize = screenToWorld(camera.viewport.effectiveSize);
    // Preload audio files
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
    // FlameAudio.loopLongAudio(AudioAssets.bgAudio, volume: 0.1);
    FlameAudio.bgm.play(AudioAssets.bgAudio);
    //FlameAudio.bgm.stop();
    addAll([
      MuralComponent(),
      BackboardComponent(),
      RimComponent(Vector2((gameSize.x / 2) + 6, 28), false),
      RimComponent(Vector2((gameSize.x / 2) - 6.7, 28), false),
      BackRimComponent(),
      FrontRimComponent(),
      BallComponent()
    ]);

    // Configure countdown timer.
  }
}

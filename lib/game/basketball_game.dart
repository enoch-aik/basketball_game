import 'package:basketball_game/backboard.dart';
import 'package:basketball_game/components/backboard.dart';
import 'package:basketball_game/components/ball.dart';
import 'package:basketball_game/components/boundary.dart';
import 'package:basketball_game/components/mural_component.dart';
import 'package:basketball_game/components/rim.dart';
import 'package:basketball_game/constants/audio.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class BasketBallGame extends Forge2DGame
    with HasDraggables, HasCollisionDetection {
  BasketBallGame() {
    //World world = World(Vector2(0,0));
  }

  ValueNotifier<int> timer = ValueNotifier(0);
  int score = 0;
  bool startedGame = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    TextComponent timerText = TextBoxComponent(
        text: '$timer',
        position: Vector2(10, 10),
        anchor: Anchor.topLeft,
        textRenderer: TextPaint(
            style: TextStyle(
                fontFamily: 'Enhanced LED Board-7',
                fontSize: 30,
                color: BasicPalette.black.color)));
    add(timerText);
    await loadAllComponents();
  }

  loadAllComponents() async {
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
  }

  @override
  void update(double dt) {
    super.update(dt);
    // timer.value +=1;
  }

  void resetTimer() {
    timer.value = 0;
  }

  void resetScore() {
    timer.value = 0;
  }
}

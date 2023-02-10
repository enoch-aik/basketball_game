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

//declaring all game overlays here
enum GameOverlays { gameOver, main, scoreboard }

class BasketBallGame extends Forge2DGame
    with HasDraggables, HasCollisionDetection {
  late Timer _timer;

  //Timer for the game
  ValueNotifier<int> timer = ValueNotifier(30);

  //Notifier for the game score
  ValueNotifier<int> score = ValueNotifier(0);
  bool startedGame = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    //load all gameComponents
    await loadAllComponents();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update timer.
    _timer.update(dt);
  }

//reset time when game is over
  void resetTimer() {
    timer.value = 30;
  }

//reset score when game is over
  void resetScore() {
    score.value = 0;
  }

//add overlay to game
  void addMenu(GameOverlays overlay) {
    overlays.add(overlay.name);
  }

//function to load all components and initiate timer
  loadAllComponents() async {
    //configure timer countdown
    _timer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (timer.value == 0) {
          // Pause the game,pause bg song and remove all balls with scoreboard components
          pauseEngine();
          removeWhere((component) => component is BallComponent);FlameAudio.bgm.pause().then(
              (value) => FlameAudio.play(AudioAssets.buzzer, volume: 0.5));

          overlays.remove(GameOverlays.scoreboard.name);
          overlays.add(GameOverlays.gameOver.name);
          // Display game over menu.
        } else {
          // Decrement time by one second.
          timer.value -= 1;
        }
      },
    );

    //Set boundaries for game screen
    final boundaries = createBoundaries(this);
    boundaries.forEach(add);
    Vector2 gameSize = screenToWorld(camera.viewport.effectiveSize);
    // Preload audio files
    await FlameAudio.audioCache.loadAll([
      AudioAssets.hitRim,
      AudioAssets.hitWall,
      AudioAssets.swish1,
      AudioAssets.swish2,
      AudioAssets.buzzer,
      AudioAssets.shoot,
      AudioAssets.shoot,
      AudioAssets.bgAudio
    ]);
    // Start game bg sound
    FlameAudio.bgm.play(AudioAssets.bgAudio);
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
}

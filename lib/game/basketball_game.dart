import 'dart:ui';

import 'package:basketball_game/components/ball.dart';
import 'package:basketball_game/components/mural_component.dart';
import 'package:basketball_game/constants/image_assets.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BasketBallGame extends FlameGame with HasDraggables {
  late World world;

  BasketBallGame(){
    world = World(Vector2(0,0));
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(MuralComponent());
    add(BallComponent());
  }
}

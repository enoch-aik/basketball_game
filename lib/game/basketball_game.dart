
import 'package:basketball_game/components/ball.dart';
import 'package:basketball_game/components/boundary.dart';
import 'package:basketball_game/components/mural_component.dart';
import 'package:basketball_game/constants/image_assets.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BasketBallGame extends Forge2DGame with HasDraggables,HasCollisionDetection {
  BasketBallGame() {
    //World world = World(Vector2(0,0));
  }

  @override
  Future<void> onLoad() async {


    await super.onLoad();
    final boundaries = createBoundaries(this);
    boundaries.forEach(add);
    Vector2 gameSize = screenToWorld(camera.viewport.effectiveSize);
    add(
      MuralComponent(),
      //BasketBallStandComponent(),
    );
    add(BallComponent(gameSize,));
  }

}

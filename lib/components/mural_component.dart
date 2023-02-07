import 'package:basketball_game/constants/image_assets.dart';
import 'package:basketball_game/game/basketball_game.dart';
import 'package:flame/components.dart';

class MuralComponent extends SpriteComponent with HasGameRef<BasketBallGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(ImageAssets.mural7);
    size = gameRef.size;
  }
}

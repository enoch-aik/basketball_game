import 'package:basketball_game/constants/image_assets.dart';
import 'package:basketball_game/game/basketball_game.dart';
import 'package:flame/components.dart';

class MuralComponent extends SpriteComponent with HasGameRef<BasketBallGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(ImageAssets.mural5);
    size = gameRef.size;
  }
}
class NewRimComponent extends SpriteComponent with HasGameRef<BasketBallGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(ImageAssets.mural5);

  }
}


import 'package:basketball_game/constants/image_assets.dart';
import 'package:flame/components.dart';

import '../game/basketball_game.dart';


class BackboardComponent extends SpriteComponent
    with HasGameRef<BasketBallGame> {

  BackboardComponent(): super(priority: 1);
  @override
  void onLoad() async{
    //load backboard component
    super.onLoad();
    sprite = await gameRef.loadSprite(ImageAssets.stand);
    position = Vector2(gameRef.size.x*0.02,7.5);
    width = gameRef.size.x*0.94;
    height = game.size.y*0.9;
    //anchor = Anchor.center;
  }
}

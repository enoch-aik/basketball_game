import 'package:basketball_game/backboard.dart';
import 'package:basketball_game/constants/image_assets.dart';
import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';

import '../game/basketball_game.dart';


class BackboardComponent extends SpriteComponent
    with HasGameRef<BasketBallGame> {

  BackboardComponent(): super(priority: 1);
  @override
  void onLoad() async{
    super.onLoad();
    sprite = await gameRef.loadSprite(ImageAssets.stand);
    position = Vector2(gameRef.size.x*0.02,7.5);
    width = gameRef.size.x*0.94;
    height = game.size.y*0.9;
    //anchor = Anchor.center;
  }
}
class BackboardSvgComponent extends SvgComponent
    with HasGameRef<BasketBallGame> {
  @override
  void onLoad() async{
    super.onLoad();
    final size = gameRef.size;
    final position = Vector2.zero();
    final svgInstance = await Svg.load(ImageAssets.standSvg);
    final svgComponent = SvgComponent(svg: svgInstance,size:size,position: position);
    //position = Vector2(gameRef.size.x*0.02,7.5);
    width = gameRef.size.x*0.94;
    height = game.size.y*0.95;
    //anchor = Anchor.center;
    add(svgComponent);
  }
}

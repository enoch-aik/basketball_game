import 'package:basketball_game/game/basketball_game.dart';
import 'package:basketball_game/screens/menu/game_over.dart';
import 'package:basketball_game/screens/menu/main_menu.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: BasketBallGame(),
      overlayBuilderMap: {
        Menu.gameOver.name: (BuildContext context, BasketBallGame gameRef) =>
            GameOverScreen(),
        /*Menu.pause.name: (BuildContext context, BasketBallGame gameRef) =>
            SettingsMenu(gameRef: gameRef),*/
      },
    );
  }
}

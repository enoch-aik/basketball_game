import 'package:basketball_game/game/basketball_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final BasketBallGame game;

  const ScoreBoard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size gameSize = game.size.toSize();
    return ValueListenableBuilder(
      valueListenable: game.timer,
      builder: (context,score,_) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 4),
          child: Container(
            width: 130,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: Material(
              child: Text(
                'Score: ${game.score}',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              elevation: 0,
              color: Colors.transparent,
            ),
          ),
        );
      }
    );
  }
}

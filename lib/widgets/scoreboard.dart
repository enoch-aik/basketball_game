import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final Game game;

  const ScoreBoard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size gameSize = game.size.toSize();
    return Container(
      width: gameSize.width * 0.7,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(20)),
    );
  }
}

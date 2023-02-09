import 'package:basketball_game/components/ball.dart';
import 'package:basketball_game/game/basketball_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GameOverScreen extends StatelessWidget {
  final BasketBallGame game;

  const GameOverScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Center(
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          width: screenSize.width * 0.8,
          height: screenSize.height * 0.3,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Text(
                  'Your score is ${game.score.value}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Enhanced LED Board-7',
                      fontSize: 18),
                ),
              ),
              SizedBox(
                  height: 40,
                  width: screenSize.width * 0.55,
                  child: ElevatedButton(
                      onPressed: () {
                        game.resetScore();
                        game.resetTimer();
                        game.resumeEngine();
                        game.overlays.add(GameOverlays.scoreboard.name);
                        game.overlays.remove(GameOverlays.gameOver.name);
                        game.removeWhere((component) {
                          return component is BallComponent;
                        });
                        game.add(BallComponent());
                      },
                      child: const Text(
                        'Play Again',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Enhanced LED Board-7',
                            fontSize: 14),
                      ).animate().fade(duration: 500.ms).scale(delay: 500.ms)))
            ],
          ),
        ),
      ),
    );
  }
}
